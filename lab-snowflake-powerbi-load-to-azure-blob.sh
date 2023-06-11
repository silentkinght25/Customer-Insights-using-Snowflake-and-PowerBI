
export blobpath='https://powersnowinsight.blob.core.windows.net/lab-data'
export sastoken='sp=racwdl&st=2023-06-09T11:45:30Z&se=2023-06-11T19:45:30Z&spr=https&sv=2022-11-02&sr=c&sig=OtyzdIXnZPWXcPnDKcgR4oI%2FGHTUVYGWjBQZg%2F0Spl4%3D'
export gitbaseurl='https://github.com/sfc-gh-ccollier/sfquickstart-samples/raw/main/samples/snowflake-powerbi-retail-vhol/lab_data'

#category
export currentpath='category'
export currentfile='category_0_0_0.csv.gz'
wget --no-verbose -O $currentfile $gitbaseurl/$currentpath/$currentfile
azcopy copy $currentfile $blobpath/$currentpath/$currentfile?$sastoken --log-level 'ERROR'
rm $currentfile

#channels
export currentpath='channels'
export currentfile='channels_0_0_0.csv.gz'
wget --no-verbose -O $currentfile $gitbaseurl/$currentpath/$currentfile
azcopy copy $currentfile $blobpath/$currentpath/$currentfile?$sastoken --log-level 'ERROR'
rm $currentfile

#department
export currentpath='department'
export currentfile='department_0_0_0.csv.gz'
wget --no-verbose -O $currentfile $gitbaseurl/$currentpath/$currentfile
azcopy copy $currentfile $blobpath/$currentpath/$currentfile?$sastoken --log-level 'ERROR'
rm $currentfile

#items
export currentpath='items'
export currentfile='items_0_0_0.csv.gz'
wget --no-verbose -O $currentfile $gitbaseurl/$currentpath/$currentfile
azcopy copy $currentfile $blobpath/$currentpath/$currentfile?$sastoken --log-level 'ERROR'
rm $currentfile

#items_in_sales_orders
export currentpath='items_in_sales_orders'; for number in {0..24}; do export currentfile='items_in_sales_orders_0_0_'$number'.csv.gz'; echo 'Processing '$currentfile; wget --no-verbose -O $currentfile $gitbaseurl/$currentpath/$currentfile; azcopy copy $currentfile $blobpath/$currentpath/$currentfile?$sastoken --log-level 'ERROR'; rm $currentfile; done
export currentpath='items_in_sales_orders'; for number in {0..24}; do export currentfile='items_in_sales_orders_0_1_'$number'.csv.gz'; echo 'Processing '$currentfile; wget --no-verbose -O $currentfile $gitbaseurl/$currentpath/$currentfile; azcopy copy $currentfile $blobpath/$currentpath/$currentfile?$sastoken --log-level 'ERROR'; rm $currentfile; done
export currentpath='items_in_sales_orders'; for number in {0..24}; do export currentfile='items_in_sales_orders_0_2_'$number'.csv.gz'; echo 'Processing '$currentfile; wget --no-verbose -O $currentfile $gitbaseurl/$currentpath/$currentfile; azcopy copy $currentfile $blobpath/$currentpath/$currentfile?$sastoken --log-level 'ERROR'; rm $currentfile; done
export currentpath='items_in_sales_orders'; for number in {0..24}; do export currentfile='items_in_sales_orders_0_3_'$number'.csv.gz'; echo 'Processing '$currentfile; wget --no-verbose -O $currentfile $gitbaseurl/$currentpath/$currentfile; azcopy copy $currentfile $blobpath/$currentpath/$currentfile?$sastoken --log-level 'ERROR'; rm $currentfile; done
export currentpath='items_in_sales_orders'; for number in {0..24}; do export currentfile='items_in_sales_orders_0_4_'$number'.csv.gz'; echo 'Processing '$currentfile; wget --no-verbose -O $currentfile $gitbaseurl/$currentpath/$currentfile; azcopy copy $currentfile $blobpath/$currentpath/$currentfile?$sastoken --log-level 'ERROR'; rm $currentfile; done
export currentpath='items_in_sales_orders'; for number in {0..24}; do export currentfile='items_in_sales_orders_0_5_'$number'.csv.gz'; echo 'Processing '$currentfile; wget --no-verbose -O $currentfile $gitbaseurl/$currentpath/$currentfile; azcopy copy $currentfile $blobpath/$currentpath/$currentfile?$sastoken --log-level 'ERROR'; rm $currentfile; done
export currentpath='items_in_sales_orders'; for number in {0..24}; do export currentfile='items_in_sales_orders_0_6_'$number'.csv.gz'; echo 'Processing '$currentfile; wget --no-verbose -O $currentfile $gitbaseurl/$currentpath/$currentfile; azcopy copy $currentfile $blobpath/$currentpath/$currentfile?$sastoken --log-level 'ERROR'; rm $currentfile; done
export currentpath='items_in_sales_orders'; for number in {0..24}; do export currentfile='items_in_sales_orders_0_7_'$number'.csv.gz'; echo 'Processing '$currentfile; wget --no-verbose -O $currentfile $gitbaseurl/$currentpath/$currentfile; azcopy copy $currentfile $blobpath/$currentpath/$currentfile?$sastoken --log-level 'ERROR'; rm $currentfile; done

#locations
export currentpath='locations'
export currentfile='locations_0_3_0.csv.gz'
wget --no-verbose -O $currentfile $gitbaseurl/$currentpath/$currentfile
azcopy copy $currentfile $blobpath/$currentpath/$currentfile?$sastoken --log-level 'ERROR'
rm $currentfile

#sales_orders
export currentpath='sales_orders';
export currentpath='sales_orders'; for number in {0..2}; do export currentfile='sales_orders_0_0_'$number'.csv.gz'; echo 'Processing '$currentfile; wget --no-verbose -O $currentfile $gitbaseurl/$currentpath/$currentfile; azcopy copy $currentfile $blobpath/$currentpath/$currentfile?$sastoken --log-level 'ERROR'; rm $currentfile; done
export currentpath='sales_orders'; for number in {0..2}; do export currentfile='sales_orders_0_1_'$number'.csv.gz'; echo 'Processing '$currentfile; wget --no-verbose -O $currentfile $gitbaseurl/$currentpath/$currentfile; azcopy copy $currentfile $blobpath/$currentpath/$currentfile?$sastoken --log-level 'ERROR'; rm $currentfile; done
export currentpath='sales_orders'; for number in {0..2}; do export currentfile='sales_orders_0_2_'$number'.csv.gz'; echo 'Processing '$currentfile; wget --no-verbose -O $currentfile $gitbaseurl/$currentpath/$currentfile; azcopy copy $currentfile $blobpath/$currentpath/$currentfile?$sastoken --log-level 'ERROR'; rm $currentfile; done
export currentpath='sales_orders'; for number in {0..2}; do export currentfile='sales_orders_0_3_'$number'.csv.gz'; echo 'Processing '$currentfile; wget --no-verbose -O $currentfile $gitbaseurl/$currentpath/$currentfile; azcopy copy $currentfile $blobpath/$currentpath/$currentfile?$sastoken --log-level 'ERROR'; rm $currentfile; done
export currentpath='sales_orders'; for number in {0..2}; do export currentfile='sales_orders_0_4_'$number'.csv.gz'; echo 'Processing '$currentfile; wget --no-verbose -O $currentfile $gitbaseurl/$currentpath/$currentfile; azcopy copy $currentfile $blobpath/$currentpath/$currentfile?$sastoken --log-level 'ERROR'; rm $currentfile; done
export currentpath='sales_orders'; for number in {0..2}; do export currentfile='sales_orders_0_5_'$number'.csv.gz'; echo 'Processing '$currentfile; wget --no-verbose -O $currentfile $gitbaseurl/$currentpath/$currentfile; azcopy copy $currentfile $blobpath/$currentpath/$currentfile?$sastoken --log-level 'ERROR'; rm $currentfile; done
export currentpath='sales_orders'; for number in {0..2}; do export currentfile='sales_orders_0_6_'$number'.csv.gz'; echo 'Processing '$currentfile; wget --no-verbose -O $currentfile $gitbaseurl/$currentpath/$currentfile; azcopy copy $currentfile $blobpath/$currentpath/$currentfile?$sastoken --log-level 'ERROR'; rm $currentfile; done
export currentpath='sales_orders'; for number in {0..2}; do export currentfile='sales_orders_0_7_'$number'.csv.gz'; echo 'Processing '$currentfile; wget --no-verbose -O $currentfile $gitbaseurl/$currentpath/$currentfile; azcopy copy $currentfile $blobpath/$currentpath/$currentfile?$sastoken --log-level 'ERROR'; rm $currentfile; done

#states
export currentpath='states'
export currentfile='states_0_0_0.csv.gz'
wget --no-verbose -O $currentfile $gitbaseurl/$currentpath/$currentfile
azcopy copy $currentfile $blobpath/$currentpath/$currentfile?$sastoken --log-level 'ERROR'
rm $currentfile
