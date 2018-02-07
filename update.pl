#!/usr/bin/perl

use DBI; 
use CGI; 

$dsn = "DBI:mysql:database=techtasks;host=localhost";
$dbh = DBI->connect($dsn,'root','');

my $cgi = new CGI ;
my $name = $cgi->param('task_id');
my $sql = "DELETE FROM tasks WHERE task_id=$name" ;
my $sth = $dbh->prepare($sql); 

$sth->execute(); 
$dbh->disconnect(); 

print "Content-Type: text/html\n\n"; 
print "<a href=\"http://192.168.2.2/perl/techtask/techtasks.pl\"> Go Back </a> "; 
return "Data deleted successfully!"; 

