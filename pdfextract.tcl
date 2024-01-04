proc start {filename pages} {
    set sepcommand "pdfseparate"
    catch {
        exec $sepcommand $filename separate-%03d.pdf
    } errorcode
    set sepfiles [glob separate-*.pdf]
    set lastpage [string range [lindex $sepfiles end] 9 11]
    lappend pages $lastpage
    for {set p 0} {$p < [expr [llength $pages]-1]} {incr p} {
        set i [lindex $pages $p]
        set j [expr [lindex $pages [expr $p+1]]-1]
        puts "Section $p: page $i - $j"
        set ofiles {}
        for {set k $i} {$k <= $j} {incr k} {
            lappend ofiles [format "separate-%03d.pdf" $k]
        }
        catch {
            exec pdfunite {*}$ofiles [format "output-%03d.pdf" $p]
        } errorcode
    } 
    foreach fn [glob separate-*.pdf] {
        file delete $fn
    }
}

if {$argc != 2} {
    puts "Usage: tclsh pdfextract.tcl orgfile.pdf pagelist.txt"
    exit
}

set orgfile [lindex $argv 0]
set pages {}
set f [open [lindex $argv 1] r]
while 1 {
    gets $f line
    if {[eof $f]} break
    lappend pages $line
}

start $orgfile $pages
