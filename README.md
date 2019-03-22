# BatchSqlOutboundAdapter

Extend EnsLib.SQL.OutboundAdapter to add batch support batch on JDBC connection.

## Benchmark

On Postgres 11.2, 1 000 000 rows fetched, 100 000 rows inserted, 2 columns.

![alt text](https://raw.githubusercontent.com/grongierisc/BatchSqlOutboundAdapter/master/Bench/screenshot.png)

## Prerequisites

Can be used on IRIS or Ensemble 2017.2+.

### Installing

Clone this repository

```
git clone https://github.com/grongierisc/BatchSqlOutboundAdapter.git
```

Use Batch.SQL.SqlOutboundAdapter adaptor.

### New methods from the adaptor

* Method **ExecuteQueryBatchParmArray**(ByRef pRS As Batch.SQL.GatewayResultSet, pQueryStatement As %String, pBatchSize As %Integer, ByRef pParms) As %Status
    * *pRS* is the ResultSet can be use as any EnsLib.SQL.GatewayResultSet
    * *pQueryStatement* is the SQL query you like to execute
    * *pBatchSize* is the fetch size JDBC parameter
* Method **ExecuteUpdateBatchParamArray**(Output pNumRowsAffected As %Integer, pUpdateStatement As %String, pParms...) As %Status 
    * *pNumRowsAffected* is the number of row inserted
    * *pUpdateStatement* is teh update/insert SQL statement
    * *pParms* is Caché Multidimensional Array
        * pParms indicate the number of row in batch
        * pParms(integer) indicate the number of parameters in the row
        * pParms(integer,integerParam) indicate the value of the parameter whose position is integerParam.
        * pParms(integer,integerParam,"SqlType") indicate the SqlType of the parameter whose position is integerParam, by default it will be $$$SqlVarchar

### Example

 * **Batch.Example.SqlSelectOperation** show an example of ExecuteQueryBatchParmArray
 * **Batch.Example.SqlSelectOperation** show an example of ExecuteUpdateBatchParamArray

### Content of this project

This adaptor include :

* Batch.SQL.Common
  * No modification, simple extend of EnsLib.SQL.Common
* Batch.SQL.CommonJ
  * No modification, simple extend of EnsLib.SQL.CommonJ
* Batch.SQL.GatewayResultSet
  * Extension of EnsLib.SQL.GatewayResultSet to gain the ablility to use fetch size.
* Batch.SQL.JDBCGateway
  * Use to allow compilation and support on Ensemble 2017.1 and lower
* Batch.SQL.OutboundAdapter
  * The new adaptor with :
    * ExecuteQueryBatchParmArray allow SQL query a distant database and specify the JDBC fetchSize
    * ExecuteUpdateBatchParamArray allow insertion in a distant database with JDBC addBatch and executeBatch
* Batch.SQL.Snapshot
  * Extend of EnsLib.SQL.Snapshot to handle Batch.SQL.GatewayResultSet and the fetch size property
