A couple of bash scripts have been provided to simplify running the Savile Row.
single.sh will run the Savile Row with the model on a single instance.
all.sh will run the Savile Row with the model on all instances.
There is a copy of each of these in both "basic/" and "extension/".

This submission does not include a copy of Savile Row,
so, in order to use the scripts,
one has to manually edit the constants at the top of each file
to refer to the location of the Savile Row executable.

After that one can run them from within the respective directories with
bash single.sh
bash all.sh
or if the files are executable
./single.sh
./all.sh

all.sh ignores any and all arguments.

single.sh accepts 0 or 1 argument.
If more are provided, single.sh will operate as if none are given.
When an argument is provided, it is treated as an instance param file for the solver.
When an argument is not provided, the solver is run with a default instance.
Example:
./single.sh instance8x8_c.param
from within the "basic/" directory will run the basic model on instance 8 c.
