Class Grongier.Example.SqlSelectOperation Extends Ens.BusinessOperation
{

Parameter ADAPTER = "Grongier.SQL.OutboundAdapter";

Property Adapter As Grongier.SQL.OutboundAdapter;

Parameter INVOCATION = "Queue";

Property FetchSize As %Integer [ InitialExpression = 500 ];

Parameter SETTINGS = "FetchSize";

// Set storage max pour ce processus

Method OnInit() As %Status
{
	Do ##super()
	SET $ZSTORAGE=2147483647
	q $$$OK
}

Method GetBatchSelect(pRequest As Ens.StringRequest, Output pResponse As Ens.StringResponse) As %Status
{
	
	set tStatus = $$$OK
	set nbRows = 0

	try{
		
		set pResponse = ##class(Ens.StringResponse).%New()
		set sqlGetView = "SELECT ID, ProductName FROM DemoData.ODS_Products"
		
		Set TimeStampStart = ##class(%Library.PosixTime).LogicalToUnixTime(##class(%Library.PosixTime).CurrentTimeStamp())

		$$$TRACE(sqlGetView)
			
		$$$ThrowOnError(..Adapter.ExecuteQueryBatch(.tRs,sqlGetView,..FetchSize))
		
		While tRs.%Next(){

			Set tID = tRs.Get("ID")

			If ##class(Grongier.Example.Product).%ExistsId(tID){
				Set tProduct = ##class(Grongier.Example.Product).%OpenId(tID)
			}
			Else {
				Set tProduct = ##class(Grongier.Example.Product).%New()
			}
			
			Set tProduct.ID = tID
			Set tProduct.Name = tRs.Get("ProductName")
			$$$ThrowOnError(tProduct.%Save())

			Do $INCREMENT(nbRows)
		}
		
		Set TimeStampEnd = ##class(%Library.PosixTime).LogicalToUnixTime(##class(%Library.PosixTime).CurrentTimeStamp())

		Set Delta = TimeStampEnd - TimeStampStart

		Set pResponse.StringValue = nbRows_" in "_Delta
	}
	catch exp
	{
		Set tStatus = exp.AsStatus()
	}
	Quit tStatus
}

Method GetInfo(pRequest As Ens.StringRequest, Output pResponse As Example.Msg.GetInfoResponse) As %Status
{
	
	set tStatus = $$$OK
	set nbRows = 0

	try{
		
		set pResponse = ##class(Example.Msg.GetInfoResponse).%New()
		set pResponse.Infos = ##class(%ListOfObjects).%New()
		set sqlGetView = "SELECT ID, ProductName FROM DemoData.ODS_Products"
		
		Set TimeStampStart = ##class(%Library.PosixTime).LogicalToUnixTime(##class(%Library.PosixTime).CurrentTimeStamp())

		$$$TRACE(sqlGetView)
			
		$$$ThrowOnError(..Adapter.ExecuteQueryBatch(.tRs,sqlGetView,..FetchSize))
		
		While tRs.%Next(){

			Set tProduct = ##class(Example.Msg.Info).%New()
					
			Set tProduct.ID = tRs.Get("ID")
			Set tProduct.ProductName = tRs.Get("ProductName")
			$$$ThrowOnError(pResponse.Infos.Insert(tProduct))

			Do $INCREMENT(nbRows)
		}
		
		Set TimeStampEnd = ##class(%Library.PosixTime).LogicalToUnixTime(##class(%Library.PosixTime).CurrentTimeStamp())

		Set Delta = TimeStampEnd - TimeStampStart

		Set pResponse.StringValue = nbRows_" in "_Delta
	}
	catch exp
	{
		Set tStatus = exp.AsStatus()
	}
	Quit tStatus
}

Method GetInfoSnapShot(pRequest As Ens.StringRequest, Output pResponse As Example.Msg.GetInfoSnapShotResponse) As %Status
{
	
	set tStatus = $$$OK
	set nbRows = 0

	try{
		
		set pResponse = ##class(Example.Msg.GetInfoSnapShotResponse).%New()
		set sqlGetView = "SELECT ID, ProductName FROM DemoData.ODS_Products"
		
		Set TimeStampStart = ##class(%Library.PosixTime).LogicalToUnixTime(##class(%Library.PosixTime).CurrentTimeStamp())

		$$$TRACE(sqlGetView)
		set tSnapShot = ##class(Grongier.SQL.Snapshot).%New()
			
		$$$ThrowOnError(..Adapter.ExecuteQueryBatch(.tSnapShot,sqlGetView,..FetchSize))

		set pResponse.Snapshot = tSnapShot
		
		Set TimeStampEnd = ##class(%Library.PosixTime).LogicalToUnixTime(##class(%Library.PosixTime).CurrentTimeStamp())

		Set Delta = TimeStampEnd - TimeStampStart

		Set pResponse.StringValue = tSnapShot.RowCount_" in "_Delta
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
	<MapItem MessageType="Example.Msg.GetInfoSnapShotRequest"> 
		<Method>GetInfoSnapShot</Method>
	</MapItem>
		<MapItem MessageType="Example.Msg.GetInfoRequest"> 
		<Method>GetInfo</Method>
	</MapItem>
	<MapItem MessageType="Ens.StringRequest"> 
		<Method>GetBatchSelect</Method>
	</MapItem>
</MapItems>
}

}
