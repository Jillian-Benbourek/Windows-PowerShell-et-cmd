#
# Cette fonction sert Ã  se connecter Ã  la base de donnÃ©es MySQL
#

#Appel du module POWERSHELL pour Mysql
[void][system.reflection.Assembly]::LoadWithPartialName("MySql.Data")
#

Function connexionMysql ()
{

	Write-Host "Connexion Ã  MySQL"

	#Paramètres de connexion Ã  la base MySQL
	#Nom utilisateur
	$dbuser = "" # le nom d'utilisateur 	
	$dbpwd = "" #mot de passe	
	$dbname = "database" #Nom de la base de données	
	$dbhost = ""#Ip base de données
	$dbport = 3306 #port

	Try
    {
        #Chaîne de connexion à Mysql
        $ConnexionMysql = "server=$dbhost;port=$dbport;uid=$dbuser;pwd=$dbpwd;database=$dbname"
         $ObjMysql = New-Object MySql.Data.MySqlClient.MySqlConnection($ConnexionMysql)
 
        $ObjMysql.Open() 
 
        #ceci est la requete SQL que vous devez modifier 
        # Ex:  $requete = "Select * FROM User"
        $requete = "Select * FROM Visiteur"
 
        $SQLCommand = New-Object MySql.Data.MySqlClient.MySqlCommand($req,$ObjMysql)
 
        $MySQLDataAdaptater = New-Object MySql.Data.MySqlClient.MySqlDataAdapter($SQLCommand)
 
        $MySQLDataSet = New-Object System.Data.DataSet
 
        $RecordCount = $MySQLDataAdaptater.Fill($MySQLDataSet)
        $OldString = $MySQLDataSet.Tables 

 
         $ObjMysql.Close()
        } 
 
    Catch
        {
        $err_detail = $_.Exception.Message
        $err = $err+ "`t Probleme connexion SQL requete  ==> $err_detail `n"
        echo "Probleme connexion SQL"
        exit
        }

}

