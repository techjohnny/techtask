#!/usr/bin/perl
use MIME::Lite; 
use DBI;
use CGI; 
$dsn = "DBI:mysql:database=techtasks;host=localhost"; 
$dbh = DBI->connect($dsn,'root',''); 

my $cgi = new CGI ; 
my $name = $cgi->param('name');
my $comments = $cgi->param('comments');  
my $task_id= $cgi->param('task_id');  
my $sth = $dbh->prepare("SELECT * FROM tasks ");  

$sth->execute(); 

print "Content-Type: text/html\n\n"; 
print "<style> .tomato { color:white; background-color:#003399; } table,th,td { border:1px solid black ; border-collapse:collapse;}   th,td { padding:5px;  } </style> " ; 
print "<table class=\"tomato\"><tr> <td> Task Id</td> <td> Date </td> <td> User </td> 
<td> Task </td> <td> Status </td> <td> Comments </td><td> Updated </td><tr>";
while (my $ref = $sth->fetchrow_hashref()) 
{
if ($ref->{'status'} =~ /Open/i) { $color = 'green' ; } else { $color = 'red' ; } ;
print " <td> $ref->{'task_id'} </td>  <td> $ref->{'submit_date'} </td>   <td> $ref->{'user'}</td>  <td> $ref->{'task'} </td> 
<td bgcolor='$color'> $ref->{'status'} </td>  <td> $ref->{'comments'} <td> $ref->{'updated'} </td></a> </td> <td bgcolor=ffffff> <a href=\"update.pl?task_id=$ref->{'task_id'}\"> Remove</a> </td><td bgcolor=ffffff><a href=\"edit.pl?task_id=$ref->{'task_id'}\"> Edit </a> </td> <tr> <br>  " ; 
} 
print "</table>"; 

print "<a href=\"http://192.168.2.2/techtasks.htm\"> Add some data </a>" ; 
print $comments; 


