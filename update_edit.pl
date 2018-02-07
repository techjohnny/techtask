#!/usr/bin/perl

use DBI; 
use CGI; 
use Time::Local;
$dsn = "DBI:mysql:database=techtasks;host=localhost";
$dbh = DBI->connect($dsn,'root','');

my $cgi = new CGI ;
my $status2 = "test";
my $task_id= $cgi->param('task_id');
my $user= $cgi->param('user');
my $task= $cgi->param('task');
my $time = localtime(); 	
my $comments= $cgi->param('comments');
my $status= $cgi->param('status');
my $sql = "UPDATE tasks set status = '$status',comments = '$comments',updated='$time' where task_id=$task_id";
my $sth = $dbh->prepare($sql); 

$sth->execute(); 
$dbh->disconnect(); 

print "Content-Type: text/html\n\n"; 
print "<a href=\"http://192.168.2.2/perl/techtask/techtasks.pl\"> Go Back </a> "; 

print "Data: $status <br>";
print "Comments: $comments";
