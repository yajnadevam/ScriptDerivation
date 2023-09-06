# ScriptDerivation

## Purpose
This is a demonstration of deriving the sign values programmatically. The code is very simple and uses manual regexes. The script simply substitutes the results of applying regex on the first inscription into the rest to filter out words that don't exist. This makes it less efficient (ie more inscriptions may be needed for resolution) but its fairly mechanical and repeatable by anyone.

The correctness of the regexes may be manually verified. A generic regex generator is a non-trivial task for the following reasons:

1. The script allows a consonant sign to represent the default /a/ vowel included or excluded
2. Matching two inscriptions with vowel overrides (ka vs ki) requires selecting only the consonant
3. Vowel signs may signify long or short if unambiguous
4. Sandhi rules are complex
5. Samasa (compound word) stems may not be in the dictionary

However, the core of the decipherment process is properly illustrated. A regex greatly reduces the search space, and by resolving one by one, the effort is essentially linear instead of exponential.

##Files:
scripts/prove.sh -- the main script

### Usage

./scripts/prove.sh 
./scripts/prove.sh 020

The first time its executed, the script will set up the dictionary
1. Download the Monier-Willaims dictionary and uncompress
2. Filter out spurious words (marked L) and unattested words
3. convert all aspirated to non-aspirated, retroflex to dentals, sibiliants to s, etc.
4. augment dictionary with declined forms, conjugations and attested words used

The prover will then run each sign using its minimal set for decipherment. Each inscription dramatically reduces the search space, to eventually one choice. Even if there are a handful of choices, it just requires manual checking to see which ones lead to a dead end.

### What if I classify signs in other ways?
Invariably an incorrect classification will lead to disjoint sets where one set of inscriptions give one value while the second set gives a different value.
### What happens if the dictionary is not augmented?
You will hit a dead end (no matches) or you will hit one or more matches that will all lead to dead ends.

For example, you may get "ja" as the value of the arrow sign but if you try to substitute ja for arrow in other inscriptions, many will be unreadable.

### What if the regexes are done in a different way? What if every verb conjugation, every noundeclension and every prefix, suffix etc are added to make a huge dictionary?
The number of such combinations is infinite. Even if you decide to stop somewhere, most of them would be irrelevant. You may succeed in increasing your search space most of which will result in deadends. You will never be able to derive different values for the signs that can read a corpus larger than the unicity distance. This is due to a fundamental principle of information theory. 

### How do we know this is all correct?
The correctness of the decipherment is judged simply by being able to read the corpus beyond the unicity distance. Even if all sign values were derived in a dream, thats the only thing that matters.
