#! /usr/bin/perl -w
use strict;
use Benchmark qw(:all);
use Data::Dumper;
use lib '/home/cjwatson';
use Debbugs::Versions;
use Debbugs::Versions::Dpkg;

my $tree;
timethis(1, sub {
    $tree = Debbugs::Versions->new(\&Debbugs::Versions::Dpkg::vercmp);
});
timethis(1, sub {
    #$tree->load(*STDIN);
    open GLIBC, '<', '/org/bugs.debian.org/versions/pkg/g/glibc';
    $tree->load(*GLIBC);
    close GLIBC;
});
timethis(1, sub {
    $tree->save(*STDOUT);
});
print $tree->buggy('glibc/2.3.5-3', [qw(glibc/2.1.1-1 glibc/2.1.1-5)], [qw(glibc/2.1.1-3 glibc/2.3.2.ds1-11)]);
timethis(0, sub {
    $tree->buggy('glibc/2.3.5-3', [qw(glibc/2.1.1-1 glibc/2.1.1-5)], [qw(glibc/2.1.1-3 glibc/2.3.2.ds1-11)]);
});
my %state = $tree->allstates([qw(glibc/2.1.1-1 glibc/2.1.1-5)], [qw(glibc/2.1.1-3 glibc/2.3.2.ds1-11)], [qw(glibc/2.3.2.ds1-22 glibc/2.3.2.ds1-2)]);
for my $ver (sort keys %state) {
    print "\$state{$ver} = $state{$ver}\n";
}
timethis(0, sub {
    $tree->allstates([qw(glibc/2.1.1-1 glibc/2.1.1-5)], [qw(glibc/2.1.1-3 glibc/2.3.2.ds1-11)], [qw(glibc/2.3.2.ds1-22 glibc/2.3.2.ds1-2)]);
});
#my %versions = map { $_ => 1 } qw( 2.3.1-17 2.3.1-16 2.3.1-15 2.3.1-14 2.3.1-13 2.3.1-12 2.3.1-11 2.3.1-10 2.3.1-9 2.3.1-8 2.3.1-7 2.3.1-6 2.3.1-5 2.3.1-4 2.3.1-3 2.3.1-2 2.3.1-1 2.2.5-15 2.2.5-14.3 2.2.5-14.2 2.2.5-14.1 2.2.5-14 2.2.5-13 2.2.5-12 2.2.5-11 2.2.5-10.0 2.2.5-9 2.2.5-8 2.2.5-7 2.2.5-6 2.2.5-5 2.2.5-4 2.2.5-3 2.2.5-2 2.2.5-1 2.2.4-7 2.2.4-6 2.2.4-5 2.2.4-4 2.2.4-3 2.2.4-2 2.2.4-1 2.2.3-11 2.2.3-10 2.2.3-9 2.2.3-8 2.2.3-7 2.2.3-6 2.2.3-5 2.2.3-4 2.2.3-3 2.2.3-2 2.2.3-1 2.2.2-4 2.2.2-3 2.2.2-2 2.2.2-1 2.2.1-4 2.2.1-3 2.2.1-2 2.2.1-1 2.2-11 2.2-10 2.2-9 2.2-8 2.2-7 2.2-6 2.2-5 2.2-4 2.2-3 2.2-2 2.2-1 2.1.97-1 2.1.96-1 2.1.95-1 2.1.94-3 2.1.94-2 2.1.94-1 2.1.3-14 2.1.3-13 2.1.3-12 2.1.3-11 2.1.3-10 2.1.3-9 2.1.3-8 2.1.3-7 2.1.3-6 2.1.3-5 2.1.3-4 2.1.3-3 2.1.3-2 2.1.3-1 2.1.2-13 2.1.2-12 2.1.2-11.0.1 2.1.2-11 2.1.2-10 2.1.2-9 2.1.2-8 2.1.2-7 2.1.2-6 2.1.2-5 2.1.2-4 2.1.2-3 2.1.2-2 2.1.2-1 2.1.2-0pre12 2.1.2-0pre11 2.1.2-0pre10 2.1.2-0pre9 2.1.2-0pre8 2.1.2-0pre7 2.1.2-0pre6 2.1.2-0pre5 2.1.2-0pre4 2.1.2-0pre3 2.1.2-0pre2 2.1.2-0pre1 2.1.1-13 2.1.1-12.3 2.1.1-12.2 2.1.1-12.1 2.1.1-12 2.1.1-11 2.1.1-10 2.1.1-9 2.1.1-8 2.1.1-7 2.1.1-6 2.1.1-5 2.1.1-4 2.1.1-3 2.1.1-2 2.1.1-1 2.1.1-0.2 2.1.1-0.1 2.1.1-0pre1.3 2.1.1-0pre1.2 2.1.1-0pre1.1 2.1.1-0pre1 2.1-4 2.1-3 2.1-2 2.1-1 2.2.5-11.2 2.2.5-11.1 2.2.5-11 2.2.5-10 2.2.5-9 2.1.3-20 2.1.3-19 2.1.3-18 2.1.3-17 2.1.3-16 2.1.3-15 2.1.3-14);
#my @versions = sort keys %versions;
#
#for my $x (@versions) {
#    print $tree->buggy($x, [qw(2.2-7 2.1.1-8 2.2.1-4 2.2.5-15 2.1.3-11 2.2.5-9 2.1.3-18)], [qw(2.1.3-20 2.2-7 2.3.1-1)]) ? "$x buggy\n" : "$x not buggy\n";
#}
