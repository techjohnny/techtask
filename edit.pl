#!/usr/bin/perl
use Time::Local; 
use DBI;
use CGI; 
$dsn = "DBI:mysql:database=techtasks;host=localhost"; 
$dbh = DBI->connect($dsn,'root',''); 
my $times = localtime();
my $cgi = new CGI ; 
my $name = $cgi->param('name');
my $task_id = $cgi->param('task_id');
my $comments = $cgi->param('comments');  
my $sth = $dbh->prepare("SELECT * FROM tasks WHERE task_id=$task_id  ");  
$sth->execute(); 
print "Content-Type: text/html\n\n"; 
print "Tasks List<br>";
while (my $ref = $sth->fetchrow_hashref()) 
{ 
print "<form method=\"post\" action=\"update_edit.pl\" >";
print "<table border=1 background=\"blue\"> <td>  <input name='task_id' value=$ref->{'task_id'}> </input></td>  <td> $ref->{'submit_date'} </td>   <td> $ref->{'user'}</td>  <td> $ref->{'task'} </td> 
<td><select name='status'>  <option  value=\"open\"> open</option> <option value=\"closed\"> closed</option></select> 
</td>
<td><textarea name='comments' rows='10' cols='30' size='100' type='textarea' value='$ref->{'comments'}'>$ref->{'comments'}</textarea>   </td> 
<td>$times </td>  
<td> <a href=\"update.pl?task_id=$ref->{'task_id'}\"> Remove</a> </td>
</td> <br> </table> " ; 
}
print "<input type=\"submit\" value=\"Update\">";
print "</form>"; 
print "<a href=\"http://192.168.2.2/techtasks.htm\">  Back to Task List </a>";
print $comments; 
