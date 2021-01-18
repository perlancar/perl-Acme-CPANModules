package Acme::CPANModules;

# DATE
# VERSION

1;
# ABSTRACT: CPAN modules

=head1 SPECIFICATION VERSION

0.1


=head1 DESCRIPTION

With the multitude of modules that are available on CPAN, it is sometimes
difficult for a user to choose an appropriate module for a task or find other
modules related in some ways to a module. Various projects like L<CPAN
Ratings|http://cpanratings.perl.org/> (where users rate and review a
distribution; now no longer accepting new submission) or
L<MetaCPAN|https://metacpan.org/> (which has a C<++> feature where logged-in
users can press a button to C<++> a module and the website will tally the number
of C<++>'s a distribution has) help to some extent. There are also various blog
posts by Perl programmers which review modules, e.g. L<CPAN Module Reviews by
Neil Bowers|http://neilb.org/reviews/>.

Acme::CPANModules is another mechanism to help, to let someone categorize
modules in whatever way she likes.

A related website/online service for "CPAN modules" is coming (when I eventually
get to it :-), or perhaps when I get some help).


=head1 CREATING AN ACME::CPANMODULES MODULE

The first step is to decide on the name of your module. It must be under the
C<Acme::CPANModules::> namespace. For example, if you create a list of your
favorite modules, you can use C<Acme::CPANModules::YOURCPANID::Favorite>. Or if
you are creating a list of modules that predict the future, you can choose
C<Acme::CPANModules::PredictingTheFuture>.

Inside the module, you must declare a hash named C<$LIST>:

 our $LIST = {
     ...
 };

The names of the keys in the hash must follow L<DefHash> convention. The basic
structure is this:

 # an example module list
 {
     summary => 'My favorite modules',
     description => <<'_',
 (Some longer description, in Markdown format)

 This is just a list of my favorite modules.
 _

     ## define features to be used by entries. this can be used to generate a
     ## feature comparison matrix among the entries.
     # entry_features => { # optional
     #     feature1 => 'Summary of feature1',
     #     feature2 => 'Summary of feature2',
     #     ...
     # },

     entries => [
         {...},
         ...
     ],

     ## specify Bencher scenario properties; "bench_" prefix will be removed
     ## when creating scenario record. see Bencher for more details.
     # bench_datasets => [ ... ],
     # bench_extra_modules => [ ... ],

     ## optional. Instruct cpanmodules script to not show the entries when
     ## viewing the list. This is sometimes convenient when the description
     ## already mentions all the entries.
     #'x.app.cpanmodules.show_entries' => 0,

 }

Each entry is another DefHash:

 # an example module entry
 {
     module => 'Data::Dump',
     summary => 'Pretty output',
     description => <<'_',
 Data::Dump is my favorite dumping module because it outputs Perl code that
 is pretty and readable.
 _

     # rating => 10, # optional, on a 1-10 scale

     # alternate_modules => [...], # if you are reviewing an undesirable module and want to suggest better alternative(s)

     # related_modules => ['Data::Dump::Color', 'Data::Dumper'], # if you want to specify related modules that are not listed on the other entries of the same list

     ## specify which features this entry supports/doesn't support. this can be
     ## used to generate feature comparison matrix. see
     ## Acme::CPANModulesUtil::FeatureMatrix.
     # features => {
     #     feature1 => 1,
     #     feature2 => 0,
     #     feature4 => {value=>0, summary=>'Irrelevant because foo bar'},
     #     ...
     # },

     ## specify Bencher scenario participant's properties; "bench_" prefix will
     ## be removed when creating participant record.
     # bench_code => sub { ... }, # or
     # bench_code_template => 'Data::Dump::dump(<data>)',
     # ...

 }

That's it. After you have completed your list, publish your Acme::CPANModules
module to CPAN.

Here's a sample of one of the simplest C<$LIST> you can have:

 $LIST = {
     summary => 'Modules that predict the future',
     entries => [
         {module=>'Zorb'},
         {module=>'Madame::Zita'},
     ],
 };

Here's another, more expanded sample:

 $LIST = {
     summary => 'Modules that predict the future',
     description => <<'_',

This list catalogs modules that predict the future. Yes, the future is
unpredictable. But we can try anyway, right?

_
     entries => [
         {
             module => 'Zorb',
             summary => 'Contact the API for the strange crystal Zorb',
             description => <<'_',

This module is an API client to Zorb, a strange crystal that supposedly fell
from the sky in 2017 near Ozark, that can change color depending on what you
feed to it. The API connects to Zorb API server managed by Crooks, Inc.

_
         },
         {
             module => 'Madame::Zita',
             summary => 'Ask Madame Zita the fortune teller',
         },
     ],
 };

For more example, see existing C<Acme::CPANModules::*> modules on CPAN.

If you are using L<Dist::Zilla> to release your distribution, this
L<Pod::Weaver> plugin might be useful for you:
L<Pod::Weaver::Plugin::Acme::CPANModules>. It will create an C<=head2 Included
modules> section which is POD rendering of your module list so users reading
your module's documentation can immediately read your list.


=head1 USING ACME::CPANMODULES MODULES

You can install the L<cpanmodules> CLI script (from the L<App::cpanmodules>
distribution). It can list installed Acme::CPANModules modules and view list
entries. To install all modules listed on an Acme::CPANModules module, you can
do something like:

 % cpanmodules ls-entries Org | cpanm -n

Putting similar/related modules together in an Acme::CPANModules can also help
the L<lcpan> script find related modules (C<lcpan related-mods>). See the lcpan
documentation or C<lcpan related-mods --help> for more details.

As mentioned earlier, a website/online service that collects and indexes all
Acme::CPANModules modules on CPAN is coming in the future. Meanwhile, there's
MetaCPAN.


=head1 SEE ALSO

C<Acme::CPANModules::*> modules

L<cpanmodules> from L<App::cpanmodules>

L<Bencher>

For categorizing CPAN authors, there are also the L<Acme::CPANAuthors> project,
complete with L<its own website|http://acme.cpanauthors.org/>.
