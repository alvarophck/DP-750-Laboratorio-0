#!/bin/bash
# Comandos ejecutados en Azure Cloud Shell (Bash) para completar el despliegue
# en la suscripcion Azure for Students. No se ejecuta en local: se pega en Cloud Shell.
# Esta pensado como registro de lo que se hizo, en orden, no para lanzarlo de una vez.

# 1. Descarga y ejecucion del script original (region aleatoria).
#    Resultado: koreacentral -> RequestDisallowedByAzure (policy de regiones permitidas).
curl -sL https://raw.githubusercontent.com/MicrosoftLearning/DP-750T00-Implement-Data-Engineering-Solutions-using-Azure-Databricks/refs/heads/main/Instructions/Labs/00-setup.sh | bash

# 2. Borrar el grupo de recursos creado en la region no permitida.
az group delete --name rg-dp750 --yes

# 3. Descargar el script a un fichero para poder pasarle la region como argumento.
curl -sL https://raw.githubusercontent.com/MicrosoftLearning/DP-750T00-Implement-Data-Engineering-Solutions-using-Azure-Databricks/refs/heads/main/Instructions/Labs/00-setup.sh -o ~/00-setup.sh

# 4. Segundo intento: spaincentral esta permitida por la policy, pero
#    Azure Databricks no esta disponible alli (LocationNotAvailableForResourceType).
bash ~/00-setup.sh spaincentral

# 5. Borrar el grupo de recursos del intento anterior.
az group delete --name rg-dp750 --yes

# 6. Tercer intento: francecentral esta en la lista de la policy y en la de Databricks.
#    Resultado: "Installation done".
bash ~/00-setup.sh francecentral

# 7. Limpieza al terminar el curso (elimina tambien el grupo gestionado de Databricks).
#    Sin ejecutar todavia: se deja para el final del curso.
# az group delete --name rg-dp750 --yes --no-wait
