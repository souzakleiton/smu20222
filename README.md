# SMU 2022.2

Material de Referência: [Provisioning an EC2 Instance with CloudFormation (part 1)](https://jennapederson.com/blog/2021/6/21/provisioning-an-ec2-instance-with-cloudformation-part-1/), de Jenna Pederson.

## IAM
Permissões de grupo:

- `AmazonEC2FullAccess`
- `AmazonVPCFullAccess`
- `AmazonSSMReadOnlyAccess`
- `AWSCloudFormationFullAccess`

## EC2
Importar chave pública. Exemplo: `etorresini@ifsc.edu.br`

## CloudFormation

Comando para criar:

```sh
aws cloudformation create-stack \
  --stack-name stack-0 \
  --template-body file://ec2+eip.yaml \
  --parameters \
    ParameterKey=AvailabilityZone,ParameterValue=sa-east-1a \
    ParameterKey=EnvironmentType,ParameterValue=dev \
    ParameterKey=KeyPairName,ParameterValue=etorresini@ifsc.edu.br
````

Comando para destruir:

```sh
aws cloudformation delete-stack --stack-name stack-0
```
