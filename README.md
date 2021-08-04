# BITS UDF

An [AutoIt](https://www.autoitscript.com/) [UDF](https://www.autoitscript.com/wiki/User_Defined_Functions) for the Microsoft Windows [Background Intelligent Transfer Service](https://docs.microsoft.com/en-us/windows/win32/bits/background-intelligent-transfer-service-portal) (BITS).

## Installation

The two files BITS.au3 and BITSConstants.au3 can in principle be stored in any directory.

## Usage

In your own script, the file BITS.au3 must then be included accordingly using the [#include directive](https://www.autoitscript.com/autoit3/docs/keywords/include.htm).  
To connect to the BITS service, the _BITS_Connect function must be called, which returns a BackgroundCopyManager object.  
Based on this object, access to all the other BITS functions is then possible.

```autoit
#include <BITS.au3>

Global $oBCM = _BITS_Connect()
```

## Support

For questions, problems, etc. that relate directly to the BITS UDF, an issue can be opened here on GitHub:  
https://github.com/DonChunior/BITS-UDF/issues

If the topic is related to AutoIt in general, the AutoIt forum is a good place to start:  
https://www.autoitscript.com/forum/

## Roadmap

For the next upcoming beta version it is planned to implement error checking and handling, as well as to add a UDF header for the [functions](https://www.autoitscript.com/wiki/UDF-spec#Headers) and [structures](https://www.autoitscript.com/wiki/UDF-spec#Headers_2).  
Furthermore, I will try to make it easier to get started by providing a number of example scripts.

<!--
## Contributing
-->

## Author

My name is Domenic Laritz and I am a [CAD](https://en.wikipedia.org/wiki/Computer-aided_design) system administrator at [Liebherr](https://www.liebherr.com/).  
In my job, I use AutoIt for smaller applications and to automate various tasks.  
In the course of my research for a project involving, among other things, the transfer of large amounts of data, I came across the BITS service and from that the idea for this UDF was born.

## Acknowledgment

Many thanks to the two AutoIt forum users [Nine](https://www.autoitscript.com/forum/profile/45007-nine/) and [Danyfirex](https://www.autoitscript.com/forum/profile/71248-danyfirex/).  
They helped me very well in solving some tricky problems.

## License

[MIT](https://choosealicense.com/licenses/mit/)
