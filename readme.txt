Versions in this project:
Python = 3.11
Pandas = 2.0.1


Alterations:
On src/tables/create_tables.py:
Line 73: In Ricardo's versions, the function dataframe.dtypes.iteritems() works, but in my Python and Pandas, it doesn't work, so it was necessary to change "iteritems" to just "items". The result is "dataframe.dtypes.items()".