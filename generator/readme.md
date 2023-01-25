ICAG generates  incremental coveing arrays by Bottom-up or Top-down strategy.

# Usage

ICAG runs as a command line tool that accepts a model file as an input and produces a incremental covering array.

Assuming installation of `JDK 11` or higher versions, following the command will generate a incremental covering array.

`java -jar icag.jar <model> <largest strength> <mode>`

## Options
* model\<br> 
A plain-text file specifies the parameters, the values of the parameters and the limitation of the parameters, which is consistent with the input model of PICT tool.
* largest strength\<br> 
An integer greater than 2  specifies the largest strength of the incremental covering array. Note that the smallest strength of the incremental covering array is 2.
* mode\<br> 
It is  either 0 or 1, indicating the strategy used to generate incremental covering arrays, where 0 means Bottom-up is used and 1 means Top-down is used.

Note that if ICAG runs on Windows,  `pict.exe` is invoked in the process of the incremental covering array generation; if ICAG runs on Linux, `pict` are invoked.
So the two files should  be put into the same directory as icag.jar.
