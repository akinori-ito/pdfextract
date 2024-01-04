# pdfextract

A tcl script for splitting/extracting sections from a PDF file. It uses pdfseparate and pdfunite commands from poppler.

`usage: tclsh pdfextract.tcl orgfile.pdf pagelist.txt`

`pagelist.txt` is a text file containing a list of beginning pages of each section, one number/line. For example,

```
1
3
5
10
```
indicates that the first section starts from page 1 and ends at page 2, the second section from page 3 to 4, etc.
