[<< Go back](../README.md#overview)

https://hub.docker.com/u/usethis

# Docker image: imagemagick

- `usethis/imagemagick:latest` [Dockerfile](Dockerfile)

## Contents

- imagemagick + ghostscript (with enabled policies to convert images to PDF etc)
- usage: just mount the current directory and use the commands

## Show versions

```bash
docker run --rm usethis/imagemagick sh -c 'gs --version && convert -version'
```

## Convert to other format

```bash
# to webp
docker run --rm -v ./imagemagick:/app usethis/imagemagick convert examples/logo.png example-logo.webp

# to png
docker run --rm -v ./imagemagick:/app usethis/imagemagick convert examples/square.jpg example-square.png

# to jpg (note differences when converting transparent backgrounds!)
docker run --rm -v ./imagemagick:/app usethis/imagemagick convert examples/logo.png example-jpg-ugly.jpg
docker run --rm -v ./imagemagick:/app usethis/imagemagick convert examples/logo.png -background black -flatten -alpha off example-jpg-bg-black.jpg
docker run --rm -v ./imagemagick:/app usethis/imagemagick convert examples/logo.png -background white -flatten -alpha off example-jpg-bg-white.jpg
docker run --rm -v ./imagemagick:/app usethis/imagemagick convert examples/logo.png -background "#41bf6b" -flatten -alpha off example-jpg-bg-hex-green.jpg

# to PDF (simple method, uses the image sizes, each page has a different size)
docker run --rm -v ./imagemagick:/app usethis/imagemagick convert examples/logo.png examples/landscape.jpg examples/square.jpg examples/portrait.jpg example-document.pdf
```

## Create custom PDF

Common dimensions: https://www.a3-size.com/a3-size-in-pixels/?size=a4&unit=px&ppi=300

| Page | Dimensions |
|-|-|
| A5 | 1748x2480 |
| A4 | 2480x3508 |
| A3 | 3508x4961 |
| A10 | 307x437 |

### Step 1: Create a list of all images

```bash
docker run --rm -v ./imagemagick:/app usethis/imagemagick find ./examples/ -type f \( -name *.png -or -name *.jpg \) | sort > ./imagemagick/example-pdf-step1.txt
```

### Step 2: Make sure each image is not larger then the given dimensions

```bash
# Note: change 2480x3508 to your dimensions
# Note: for a padding of 200, subtract it from the resolution: 2280x3308

# Example: with upscaling (the images can grow beyond their original sizes)
docker run --rm -v ./imagemagick:/app usethis/imagemagick convert @./example-pdf-step1.txt -resize 2280x3308 example-pdf-step2-%d.png

# Or: without upscaling (the images will not be bigger then their original resolution) -> add '\>' after resize
docker run --rm -v ./imagemagick:/app usethis/imagemagick convert @./example-pdf-step1.txt -resize 2280x3308\> example-pdf-step2-%d.png
```

### Step 3: Scale the background of the image to match the wanted dimensions

```bash
# Note: change 307x437 to your dimensions
# Note: change '-background white' to your prefered color (black, '#41bf6b', ...)
docker run --rm -v ./imagemagick:/app usethis/imagemagick convert example-pdf-step2-*.png -background 'white' -gravity center -extent 2480x3508 example-pdf-step3-%d.png
```

### Step 4: Combine all pngs into 1 PDF

```bash
docker run --rm -v ./imagemagick:/app usethis/imagemagick convert example-pdf-step3-*.png example-pdf-step4.pdf
```


### One-liner

Well almost... create the txt file with a list of images first (step 1)

```bash
# A4, no upscale
docker run --rm -v ./imagemagick:/app usethis/imagemagick sh -c 'WIDTH=2480;HEIGHT=3508;PADDING=200;BACKGROUND="white";INPUT=./example-pdf-step1.txt;OUTPUT=./example-a4-no-upscale.pdf; INNERWIDTH=$((${WIDTH}-${PADDING})) && INNERHEIGHT=$((${HEIGHT}-${PADDING})) && OUTER="${WIDTH}x${HEIGHT}" && INNER="${INNERWIDTH}x${INNERHEIGHT}" && echo -e "\nPADDING=${PADDING}\nOUTER=${OUTER}\nINNER=${INNER}\nINPUT=${INPUT}\n" && cat $INPUT && echo -e "\n[1/3] resizing to max fit" && convert @$INPUT -resize ${INNER}\> /tmp/page-%d.png && echo "[2/3] resizing background to exact resolution" && convert /tmp/page-*.png -background ${BACKGROUND} -gravity center -extent ${OUTER} /tmp/page-%d.png && echo "[3/3] generating pdf" && convert /tmp/page-*.png "${OUTPUT}"'

# A4, upscale
docker run --rm -v ./imagemagick:/app usethis/imagemagick sh -c 'WIDTH=2480;HEIGHT=3508;PADDING=200;BACKGROUND="white";INPUT=./example-pdf-step1.txt;OUTPUT=./example-a4-upscale.pdf; INNERWIDTH=$((${WIDTH}-${PADDING})) && INNERHEIGHT=$((${HEIGHT}-${PADDING})) && OUTER="${WIDTH}x${HEIGHT}" && INNER="${INNERWIDTH}x${INNERHEIGHT}" && echo -e "\nPADDING=${PADDING}\nOUTER=${OUTER}\nINNER=${INNER}\nINPUT=${INPUT}\n" && cat $INPUT && echo -e "\n[1/3] resizing to max fit" && convert @$INPUT -resize ${INNER} /tmp/page-%d.png && echo "[2/3] resizing background to exact resolution" && convert /tmp/page-*.png -background ${BACKGROUND} -gravity center -extent ${OUTER} /tmp/page-%d.png && echo "[3/3] generating pdf" && convert /tmp/page-*.png "${OUTPUT}"'
```

## Adjust image quality (1-100)

```bash
docker run --rm -v ./imagemagick:/app usethis/imagemagick convert examples/portrait.jpg -quality 80 example-quality-80.webp

docker run --rm -v ./imagemagick:/app usethis/imagemagick convert examples/portrait.jpg -quality 80 example-quality-80.jpg

docker run --rm -v ./imagemagick:/app usethis/imagemagick convert examples/portrait.jpg -quality 80 example-quality-80.png
```

Note: at 100% quality the filesize has largely increased, depending on the usecase you might settle for a smaller resolution (the 80% quality of webp and jpg seems good enough for a website)

| Quality | Filesize (webp) | Filesize (jpg) | Filesize (png) |
| - | - | - | - |
| original (jpg) | - | 414 kB | - |
| 100 | 457 kB | 416 kB | 696 kB |
| 90 | 53 kB | 100 kB | 669 kB |
| 80 | 22 kB | 55 kB | 648 kB |
| 70 | 18 kB | 39 kB | 648 kB |
