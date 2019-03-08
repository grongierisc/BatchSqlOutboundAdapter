Include EnsSQLTypes

Class Batch.Example.SqlInsertOperation Extends Ens.BusinessOperation
{

Parameter ADAPTER = "Batch.SQL.OutboundAdapter";

Property Adapter As Batch.SQL.OutboundAdapter;

Property batch As %Integer [ InitialExpression = 10 ];

Property insertSize As %Integer [ InitialExpression = 10000 ];

Parameter SETTINGS = "batch,insertSize";

Parameter INVOCATION = "Queue";

// Set storage max pour ce processus

Method OnInit() As %Status
{
	Do ##super()
	SET $ZSTORAGE=2147483647
	q $$$OK
}

Method SetResultSetView(pRequest As Ens.StringRequest, Output pResponse As Ens.StringResponse) As %Status
{
	set tStatus = $$$OK
	
	try{
					
		set nbLignes = 0
		set pResponse = ##class(Ens.StringResponse).%New()
		
		//Pour les tests, on truncate les tables avant insertion
		$$$ThrowOnError(..Adapter.ExecuteUpdate(.nrows,"DROP TABLE ODS_Products"))

		//Creer la table pour l'exemple
		$$$ThrowOnError(..Adapter.ExecuteUpdate(.nrows,"CREATE TABLE ODS_Products (id int4 NULL,productname varchar NULL,date_alimentation date NULL)"))		
		
		
		set SqlInsertView = "INSERT into ODS_Products (ID,ProductName,Date_Alimentation) values (?,?,TO_DATE(?,'yyyy-mm-dd hh24:mi:ss'))"

		$$$TRACE(SqlInsertView)
		
		set batch = ..batch
				
		set end =""
		for i=0:1:..insertSize{
			
			set param = ""
			
			for k=1:1:batch {
				
				
					
					set param(k,1) = i
					set param(k,1,"SqlType")=$$$SqlInteger

					set param(k,2) = ##class(%PopulateUtils).Name()
					set param(k,2,"SqlType")=$$$SqlVarchar
				
					set param(k,3) = $ZDATETIME($NOW(),3)
					set param(k,3,"SqlType")=$$$SqlVarchar

					set param(k) = 3

				set i = i + 1
				q:(i=..insertSize)
							
				}	
		     
			set param = k
			
			$$$ThrowOnError(..Adapter.ExecuteUpdateBatchParamArray(.nrows,SqlInsertView,.param))
							
			k param
				
			set nbLignes = nbLignes + nrows
				
	}
		set pResponse.StringValue = nbLignes
		
	}
	catch exp
	{
		Set tStatus = exp.AsStatus()
	}

	Quit tStatus
}

XData MessageMap
{
<MapItems>
	<MapItem MessageType="Ens.StringRequest"> 
		<Method>SetResultSetView</Method>
	</MapItem>
</MapItems>
}

}
