versions=(v1.13.12 v1.14.10 v1.15.9 v1.16.6 v1.17.2)
kube_val_version=0.14.0
for ver in "${versions[@]}"
do
    docker build . --build-arg KUBECTL_VERSION=$ver \
                --build-arg KUBEVAL_VERSION=$kube_val_version \
                -t kubectl:$ver
    docker tag kubectl:$ver poznajkubernetes/kubectl:$ver
    docker push poznajkubernetes/kubectl:$ver
    docker tag kubectl:$ver poznajkubernetes/kubectl:$shortver
    docker push poznajkubernetes/kubectl:$shortver
done