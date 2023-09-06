#!/usr/bin/perl -l
use List::Util 'first';
use Class::Struct;

open(my $fh, '<', "mw.txt")
   or die("Can't open mw.txt: $!\n");

my @dict = <$fh>;
chomp @dict;
close $fh;

$which = $ARGV[0];

my %VALUES = ();

my $readtexts = &readtexts();
my @texts = @$readtexts;

for my $text (@texts) {
    &resolve($text);
}

for(sort keys %VALUES) {
    print "$_ = @{$VALUES{$_}}"
}

sub resolve {
    my ($textset) = @_;
    # print "TS @$textset";
    $char = shift @$textset;
    if($which) { next unless($which && $char =~/^$which/);}
    # print "CHAR @$char";
    my @options = ();
    for my $lines (@$textset) {
      for my $text (@$lines) {
        my ($line) = @$text; 
        my ($cisi, $inscr, $re) = @$text;
        print "$char $cisi INSCR $inscr REGEX $re";

        if(scalar @options > 0) {
            my $optset = "(". join("|", @options) . ")";
            $re =~ s/\(\..*?\)/$optset/;
        }
        my @matches = grep { /^$re$/ } @dict;
        print "$inscr $re matches @matches[0..9]";
        @options = ();
        for(@matches) {
            if (/^$re$/) { push @options, "$1" }
        }
        #s/^(.)a$/$1/ for @options;
      }
    }
    if(scalar @options > 1) {
                my $inxdex = 0; 
                my $count = scalar @options;
                while($index <= $count) {
                    last if $options[$index] eq 'an';
                    $index++;
                }
                splice(@options, $index, 1);    
    }
    # print "$char OPTS @options";
    $VALUES{$char} = \@options;
}

sub readtexts {
    print "Reading corpus...";
    open(my $fh, '<', "./data/testcorpus.txt") || die "Cannot open data/testcorpus.txt";
    my @corpus = <$fh>;
    close $fh;
    chomp(@corpus);

    my $texts = [];
    my $glyphs = [];
    my $glyph = undef;

    for(@corpus) {
        s/(.*?)\#.*/$1/; # Remove comments
        next if /^\s*$/; # Skip blank lines
        if (/^.*\:/) {
            push(@$texts, [$glyph, $glyphs]) if $glyph;
            $glyphs = [];
            $glyph = $_;
        }
        else {
            s/^\s+|\s+$//g;
            my ($cisi, $inscr, $regex) = split(/\s+/, $_);
            push @$glyphs, [$cisi, $inscr, $regex];
            print "CISI $cisi INSCR $inscr REGEX $regex";
        }
    }
    push(@$texts, [$glyph, $glyphs]) if $glyph;
    print "Reading corpus...done";

    return $texts;
}