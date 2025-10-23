# Repositorio para la entrega 4 de DevOps

En éste repositorio se implementó lo de la 2da entrega pero utilizando Terraform

#### Nota: Cabe aclarar que para éste ejercicio se utilizó la nube de Google (GCP), debido a que ni en Azure ni en AWS me pude registrar.

# Paso a paso para el despliegue correcto

1. Verificar la cuenta de Google y las variables del CLI.
2. Hacer los siguientes comandos terraform.
```bash

terraform init #Para instalar los providers
terraform apply

```
3. Opcional: si se desea eliminar lo creado con terraform, proceder con el siguiente comando.
```bash

terraform destroy

```

# Servicios implementados:

Se implementaron los siguientes servicios de GCP:
1. Artifact Registry
2. Cloud Run
3. Cloud SQL
4. Secret Manager
5. Cloud Build (por medio de un documento .yaml)
6. Cloud Storage

