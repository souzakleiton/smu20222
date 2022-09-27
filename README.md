# SMU 2022.2

Material de Referência: [AWS > Documentation > AWS CloudFormation > User Guide > Sample templates > South America (Sao Paulo) region](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/sample-templates-services-sa-east-1.html).

## IAM
Adicionar as seguintes permitessões ao grupo de operadores:

- `AmazonEC2FullAccess`
- `AmazonVPCFullAccess`
- `AmazonSSMReadOnlyAccess`
- `AWSCloudFormationFullAccess`

## EC2

Importar chave pública. Pode ser gerada na própria AWS ou localmente:

```sh
ssh-keygen -t ed25519 -C <nome-da-chave> -f <arquivo>
```

e importar com:

```sh
aws ec2 import-key-pair --key-name <nome-da-chave> \ 
--public-key-material fileb://<arquivo>.pub
```

## CloudFormation

Comando para criar:

```sh
aws cloudformation create-stack \
--stack-name <nome-da-pilha> \
--template-body file://ec2+eip.json \
--parameters ParameterKey=KeyName,ParameterValue=<nome-da-chave>
````

onde `<nome-da-chave>` é o mesmo valor informado para criar a chave pública em [EC2](#ec2).

Comando para destruir:

```sh
aws cloudformation delete-stack --stack-name <nome-da-pilha>
```
