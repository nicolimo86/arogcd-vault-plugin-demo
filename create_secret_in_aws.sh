aws secretsmanager create-secret \
    --name "argocd-vault-plugin/demo" \
    --description "Secret to be read by argocd vault plugin" \
    --secret-string "{\"KeySecret\":\"dummyValue\"}"
