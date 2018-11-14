$subscription = "3191ba83-be2b-4b29-8409-f06e2fbb65bd"
$rg_name = "MLADSF2018"
$acr_name = "MLADSF2018"

"Set Subscription"
az account set --subscription $subscription

"Build Container"
$acr_login_server = az acr show --name $acr_name --query loginServer --output tsv

cd .\Container

docker build -t frame_reduction .

$tag = "{0}/frame_reduction" -f $acr_login_server

docker tag frame_reduction $tag

"Push Container to Azure Container Registry"

az acr login --name $acr_name

docker push $tag