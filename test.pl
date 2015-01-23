$|=1;
while (<>) {
my $channel = "";
if (s/^(\d+\s+)//o) {
$channel = $1;
}
$_ =~ s/(\s+.+)//o;
if ( $_ =~ m/^https?:\/\/.*/){
print $channel, "OK store-id=$_";
} else {
print "Mohon maaf format yang anda masukkan salah\n"
}
}