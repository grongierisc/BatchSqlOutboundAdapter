Class Batch.Example.SqlSelectOperation Extends Ens.BusinessOperation
{

Parameter ADAPTER = "Batch.SQL.OutboundAdapter";

Property Adapter As Batch.SQL.OutboundAdapter;

Parameter INVOCATION = "Queue";

Property ViewPrefix As %String [ InitialExpression = "VBO%" ];

Parameter SETTINGS = "ViewPrefix";

// Set storage max pour ce processus

Method OnInit() As %Status
{
	Do ##super()
	SET $ZSTORAGE=2147483647
	q $$$OK
}

Method GetResultSetView(pRequest As Ens.StringRequest, Output pResponse As Ens.StringResponse) As %Status
{
	
	set tStatus = $$$OK
	set nbIntervenants = 0
	try{
		
		set pResponse = ##class(Ens.StringResponse).%New()
		set sqlGetView = "SELECT ID, ProductName FROM DemoData.dbo.Products"
		
		$$$TRACE(sqlGetView)
		
		Set pSnap = ##class(Batch.SQL.Snapshot).%New()
		
		//dimension du snapshot
		// -1 = Max
		set pSnap.MaxRowsToGet = -1
				
		$$$ThrowOnError(..Adapter.ExecuteQueryBatch(.tRs,sqlGetView,500))
		
		$$$ThrowOnError(pSnap.ImportFromResultSet(tRs,0))
		
		$$$ThrowOnError(pSnap.%Save())
		
	
		set pResponse.StringValue = pSnap.%GblRef	
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
	<MapItem MessageType="Ens.Request"> 
		<Method>GetResultSetView</Method>
	</MapItem>
</MapItems>
}

}
