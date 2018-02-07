#!/usr/bin/perl
use POSIX qw(strftime);
use DBI; 
use CGI; 
use MIME::Lite; 

$dsn = "DBI:mysql:database=techtasks;host=localhost";
$dbh = DBI->connect($dsn,'root','');

my $date = strftime "%Y-%m-%d", localtime; 
my $cgi = new CGI ;
my $user= $cgi->param('user');
my $task= $cgi->param('task');
my $status= $cgi->param('status');
my $comments= $cgi->param('comments');
my $sql = "INSERT into tasks (submit_date,user,task,status,comments) 
values (\"$date\",\"$user\",\"$task\",\"$status\",\"$comments\")"; 
my $sth = $dbh->prepare($sql); 


$msg = MIME::Lite->new(
        From=>'jplane@cobaltent.com',
        To=>'jplane@cobaltent.com',
        Subject=>"New Task $task $comments", 
        Type=>'text',
        Path=>'/tmp/data'
        );
open(FILE,">","/tmp/data");
$msg->send;

$sth->execute(); 
$dbh->disconnect(); 

print "Content-Type: text/html\n\n"; 
print "<a href=\"http://192.168.2.2/perl/techtask/techtasks.pl\"> Go Back </a> ";

print "<br> <br> The following task was added: $date,$user,$task,$status,$comments"; 
