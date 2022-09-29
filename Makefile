PILHA=smu
ARQUIVO=ec2+eip.json
CHAVE=gitpod

all: create

create:
	aws cloudformation create-stack \
	--stack-name ${PILHA} \
	--template-body file://${ARQUIVO} \
	--parameters ParameterKey=KeyName,ParameterValue=${CHAVE}

describe:
	aws cloudformation describe-stacks

destroy:
	aws cloudformation delete-stack --stack-name ${PILHA}
