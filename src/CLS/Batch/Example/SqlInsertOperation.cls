Include EnsSQLTypes

Class Batch.Example.SqlInsertOperation Extends Ens.BusinessOperation
{

Parameter ADAPTER = "Batch.SQL.OutboundAdapter";

Property Adapter As Batch.SQL.OutboundAdapter;

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
			
		//Get SnapShot
		Set pSnap = ##class(Batch.SQL.Snapshot).%New()
		set pSnap.%GblRef = pRequest.StringValue
		set pSnap.%CurrentRow = 0
		set pSnap.FirstRow = 1
		set pSnap.MaxRowsToGet = pSnap.RowCountGet()
		
		//Pour les tests, on truncate les tables avant insertion
		$$$ThrowOnError(..Adapter.ExecuteUpdate(.nrows,"TRUNCATE TABLE ODS_Products"))		
		
		
		set SqlInsertView = "INSERT into ODS_Products (ID,ProductName,Date_Alimentation) values (?,?,TO_DATE(?,'yyyy-mm-dd hh24:mi:ss'))"

			$$$TRACE(SqlInsertView)
		
		set batch = 10
				
		set end =""
		while 'pSnap.AtEndGet() {
			
			set param = ""
			
			for k=1:1:batch {
				set end = pSnap.Next()
				set:(('end) && (k'=batch)) k = k-1
				q:('end)
					
					set param(k,1) = pSnap.Get("ID")
					set param(k,1,"SqlType")=pSnap.GetColumnSQLType(pSnap.GetColumnID("ID"))

					set param(k,2) = pSnap.Get("ProductName")
					set param(k,2,"SqlType")=pSnap.GetColumnSQLType(pSnap.GetColumnID("ProductName"))
				
					set param(k,3) = $ZDATETIME($NOW(),3)
					set param(k,3,"SqlType")=$$$SqlVarchar

					set param(k) = 3
							
				}	
		     
			set param = k
			
			$$$ThrowOnError(..Adapter.ExecuteUpdateBatchParamArray(.nrows,SqlInsertView,.param))
							
			k param
				
			set nbLignes = nbLignes + nrows
			q:('end)
				
	}
		set pResponse.StringValue = nbLignes
		
	}
	catch exp
	{
		Set tStatus = exp.AsStatus()
	}
	
	//Finaly Clean RS
	d pSnap.Clean()

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
