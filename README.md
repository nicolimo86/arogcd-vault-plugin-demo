
Create the `argocd-vault-plugin-credentials` secret, that is going to allow Argo CD to authenticate to AWS Secrets Manager.
Copy the following content in /tmp/secret-awssecretsmanager.yaml:
kind: Secret
apiVersion: v1
metadata:
  name: argocd-vault-plugin-credentials
  namespace: argocd
type: Opaque
stringData:
  AVP_TYPE: "awssecretsmanager"
  AWS_REGION: "eu-west-1"
  AWS_ACCESS_KEY_ID: "***"
  AWS_SECRET_ACCESS_KEY: "***"

 kubectl apply -f /tmp/secret-awssecretsmanager.yaml

# 2) RESTART ARGOCD 
kubectl rollout restart deployment/argocd-repo-server

# 3) CREATE ARGOCD APPLICATION
kubectl apply -f ./argocd-application.yml

# 4) VERIFY IF ARGOCD FETCHED THE SECRET FROM AWS SECRETS MANAGER
kubectl get secret example-secret -o jsonpath='{.data.sample-secret}' -n argocd-vault-plugin-poc | base64 --decode
