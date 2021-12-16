### Section Header Flags Definitions

|Flag|Descriptions|
|---|---|
|W|writable during execution|
|A|Memory is allocated for this section during process execution|
|x|Contains executable instructions|
|M|Section data may be merged to eliminate duplication -> check for same name, type and flags|
|S|data elements i nthe section consist of null-terminated character strings|
|l|Specific large sections for x86_64 architecture. This flag is not in Generic ABI but in x86_64 ABI|
|I|Info field of this section header holds an index of a section header|
|L|Preserve section ordering when linking. This section is combined with other sections in the output file in the same relative order with respect to those sections. (*Link* field of this sections heaader references another section)|
|G|This section is a member of a section group|
|T|This section holds Thread-Local Storage, meaning that each thread has its own distinct instance of this data.|
|E|Link editor is to exclude this section from executable and shared library that it builds when those obejcts are not to be further relocated|
|x|Unknown flag to readelf|
|O|Sections requires special OS-specific linking processing to avoid incorrect behavior|
|o|All bits included inthis flag are reserved for operating system-specific semantics|
|p|All bits included in this flag are reserved for processor-specific semantics|