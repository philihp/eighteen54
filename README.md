# Eighteen54

This is a totally bare implementation of Lonny Orgler's 1854, a board game based on 1829 by Francis Tresham.

I decided after two 6-hour sessions of this game that it really should be played asynchronously and in virtual
space. Not that there isn't some merit to playing the game in person over the table, it's simply unreasonable
to ask 4 people to commit that much time to a game that requires at least 3 sessions before one can begin to
understand the complexities of the game.

To that end, I'm writing this. It simply maintains board state online. The intention is to provide a minimal
amount of security (maybe a game password), but allow for the players to maintain the state of the board, and
offer a reasonable amount of accounting and perhaps optimal routing to the game.

* Accounting in this game is annoying. So you have 340g, and you want to open a company and purchase 60% of the
shares at a maximum par value? There's some math that a computer can solve for you. A company just ran a line
for 210g, and it needs to issue dividends split 60%/40%? That's something the computer can solve for you.
* Did your company remember to collect its mail contract? You shouldn't have to.
* Company wants to run a line, but isn't sure what the maximum route is around the cities of Vorarlberg? Maybe
this can be answered for you? Presumably a company would always want to operate its most valuable line.

I'm writing this in stock Ruby on Rails 5, becuase how can you write a train game in anything other than Rails?

## Contributing

If you're interested, please just contact me. I'd love some help. If the last commit is over a month old,
chances are I found something else interesting to do.
