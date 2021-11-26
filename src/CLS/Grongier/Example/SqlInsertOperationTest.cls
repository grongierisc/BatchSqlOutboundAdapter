Include EnsSQLTypes

Class Grongier.Example.SqlInsertOperationTest Extends Ens.BusinessOperation
{

Parameter ADAPTER = "Grongier.SQL.OutboundAdapter";

Property Adapter As Grongier.SQL.OutboundAdapter;

Property batch As %Integer [ InitialExpression = 10 ];

Property insertSize As %Integer [ InitialExpression = 10 ];

Parameter SETTINGS = "batch,insertSize";

Parameter INVOCATION = "Queue";

// Set max RAM memory for this process

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
		
		
		//Insert into DMLSS_AM.Assemblage_Instance (SITEID,Sub_Organization_Identifier_sub_org_ID,Sub_Organization_Description,Sub_Organization_Unit_Identification_Code_UIC,Assemblage_Owner_or_Manager_Organization_Branch_of_Service_Code,Assemblage_Identifier,Assemblage_Increment,Assemblage_Sub_Assemblage,Assemblage_Instance_Number,Assm_BCNMRL,Item_Identifier_for_the_Assemblage,Assemblage_Unit_Type_Code_UTC,Assm_Project_Code,Assemblage_Ownership_Purpose_Code,Assemblage_Ownership_Purpose_Code_Description,Assm_ERC_Code,Assemblage_Branch_of_Service_Code,Assm_UIC,Assemblage_Description,Assemblage_Outship_Indicator,Misc_Owned_Fund_Center_or_Customer_Organization_Identifier,Customer_Name,Inventory_Date,Allowance_Standard_Date,Assemblage_Ownership_Code,Sub_Organization_Category_Code,Assemblage_Instance_Serial_Identifier,Sub_Assemblage_Gross_Critical_MAV,Sub_Assemblage_Gross_Total_MAV,Sub_Assemblage_Detail_Critical_MAV,Sub_Assemblage_Detail_Total_MAV,Assemblage_Instance_Gross_Critical_MAV,Assemblage_Instance_Gross_Total_MAV,Assemblage_Instance_Detail_Critical_MAV,Assemblage_Instance_Detail_Total_MAV) values ( '556',?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)

		Set TimeStampStart = ##class(%Library.PosixTime).LogicalToUnixTime(##class(%Library.PosixTime).CurrentTimeStamp())

		//Pour les tests, on truncate les tables avant insertion
		$$$ThrowOnError(..Adapter.ExecuteUpdate(.nrows,"DROP TABLE IF EXISTS DemoData.Assemblage_Instance"))

		//Creer la table pour l'exemple
		$$$ThrowOnError(..Adapter.ExecuteUpdate(.nrows,"CREATE TABLE DemoData.Assemblage_Instance (SITEID varchar NULL,Sub_Organization_Identifier_sub_org_ID varchar NULL,Sub_Organization_Description varchar NULL,Sub_Organization_Unit_Identification_Code_UIC varchar NULL,Assemblage_Owner_or_Manager_Organization_Branch_of_Service_Code varchar NULL,Assemblage_Identifier varchar NULL,Assemblage_Increment varchar NULL,Assemblage_Sub_Assemblage varchar NULL,Assemblage_Instance_Number varchar NULL,Assm_BCNMRL varchar NULL,Item_Identifier_for_the_Assemblage varchar NULL,Assemblage_Unit_Type_Code_UTC varchar NULL,Assm_Project_Code varchar NULL,Assemblage_Ownership_Purpose_Code varchar NULL,Assemblage_Ownership_Purpose_Code_Description varchar NULL,Assm_ERC_Code varchar NULL,Assemblage_Branch_of_Service_Code varchar NULL,Assm_UIC varchar NULL,Assemblage_Description varchar NULL,Assemblage_Outship_Indicator varchar NULL,Misc_Owned_Fund_Center_or_Customer_Organization_Identifier varchar NULL,Customer_Name varchar NULL,Inventory_Date varchar NULL,Allowance_Standard_Date varchar NULL,Assemblage_Ownership_Code varchar NULL,Sub_Organization_Category_Code varchar NULL,Assemblage_Instance_Serial_Identifier varchar NULL,Sub_Assemblage_Gross_Critical_MAV varchar NULL,Sub_Assemblage_Gross_Total_MAV varchar NULL,Sub_Assemblage_Detail_Critical_MAV varchar NULL,Sub_Assemblage_Detail_Total_MAV varchar NULL,Assemblage_Instance_Gross_Critical_MAV varchar NULL,Assemblage_Instance_Gross_Total_MAV varchar NULL,Assemblage_Instance_Detail_Critical_MAV varchar NULL,Assemblage_Instance_Detail_Total_MAV varchar NULL)"))		

		set SqlInsertView = "Insert into DemoData.Assemblage_Instance (SITEID,Sub_Organization_Identifier_sub_org_ID,Sub_Organization_Description,Sub_Organization_Unit_Identification_Code_UIC,Assemblage_Owner_or_Manager_Organization_Branch_of_Service_Code,Assemblage_Identifier,Assemblage_Increment,Assemblage_Sub_Assemblage,Assemblage_Instance_Number,Assm_BCNMRL,Item_Identifier_for_the_Assemblage,Assemblage_Unit_Type_Code_UTC,Assm_Project_Code,Assemblage_Ownership_Purpose_Code,Assemblage_Ownership_Purpose_Code_Description,Assm_ERC_Code,Assemblage_Branch_of_Service_Code,Assm_UIC,Assemblage_Description,Assemblage_Outship_Indicator,Misc_Owned_Fund_Center_or_Customer_Organization_Identifier,Customer_Name,Inventory_Date,Allowance_Standard_Date,Assemblage_Ownership_Code,Sub_Organization_Category_Code,Assemblage_Instance_Serial_Identifier,Sub_Assemblage_Gross_Critical_MAV,Sub_Assemblage_Gross_Total_MAV,Sub_Assemblage_Detail_Critical_MAV,Sub_Assemblage_Detail_Total_MAV,Assemblage_Instance_Gross_Critical_MAV,Assemblage_Instance_Gross_Total_MAV,Assemblage_Instance_Detail_Critical_MAV,Assemblage_Instance_Detail_Total_MAV) values ( '556',?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"

		$$$LOGINFO(SqlInsertView)
		
		set batch = ..batch
				
		set end =""
		set data = "115111|MORGANS AWESOME HOSPITAL|365115|VA|MAH|01|0|1||||||||VA||ICECREAM OPERATION|N|744105|DESERT CONTINGENCY|||C|ORG|7|0|99|0|100|0|99|0|100|"
		set i=0
		while i<..insertSize{
			
			set param = ""
			
			for k=1:1:batch {
				
				Set dataFields = $L(data,"|")-1

				for i=1:1:dataFields {
					set tmpValue=$P(data,"|",i)

					Set param(k,i) = tmpValue
					Set param(k,i,"SqlType") = $$$SqlVarchar 
				}

				set param(k) = dataFields

				$$$LOGINFO(dataFields)

				set i = i + 1
				q:(i>=..insertSize)
							
				}	
		     
			set param = k
			
			set sc = ..Adapter.ExecuteUpdateBatchParamArray(.nrows,SqlInsertView,.param)

			$$$LOGINFO(sc)	

			k param
				
			set nbLignes = nbLignes + nrows
				
	}

	Set TimeStampEnd = ##class(%Library.PosixTime).LogicalToUnixTime(##class(%Library.PosixTime).CurrentTimeStamp())

	Set Delta = TimeStampEnd - TimeStampStart

	set pResponse.StringValue = nbLignes_" in "_Delta
		
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
