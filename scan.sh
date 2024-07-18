# Download latest vulnerability database
docker volume rm trivy_cache
docker volume create trivy_cache
docker run --rm -v trivy_cache:/trivy_cache aquasec/trivy image --cache-dir /trivy_cache --download-db-only

# Fetch local images
images=$(docker images rboonzaijer/* --format '{{.Repository}}:{{.Tag}}' | sort -k1 -h)

# Scan each image
for image in $images
do
    name=$(echo $image | sed "s/:/_/g" | sed "s/\//_/g" | sed "s/[^[:alnum:]_-]//g")

    if [ "$image" == "rboonzaijer/ansible:latest" ] || [ "$image" == "rboonzaijer/ansible:2.17.2" ]; then
        # the ansible image contains examples of private keys, so it gives a lot of errors, ignore those
        docker run --rm --name "trivy-scan-$name" -v trivy_cache:/trivy_cache -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy image --quiet --cache-dir /trivy_cache --skip-db-update --scanners 'vuln' $image
    else
        docker run --rm --name "trivy-scan-$name" -v trivy_cache:/trivy_cache -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy image --quiet --cache-dir /trivy_cache --skip-db-update --scanners 'vuln,secret' $image
    fi
done
