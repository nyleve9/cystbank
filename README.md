# cystbank
QCB proj

Introduction
	The San Diego fairy shrimp, Branchinecta sandiegonensis, is an ethereal, some would say attractive, upside-down swimming species of branchiopod that is found the vernal pools atop mesas in San Diego County, California.  Described and given its regrettably lackluster name by a professor from UC Riverside in 1993, B. sandiegonensis can be distinguished from other Southern Californian fairy shrimp by several intriguing characters, such as egg morphology, ovisac length, and the form of the second antenna in males (Fugate 1993).  Members of this species are similar to other fairy shrimp in the way that their large size and slow, leisurely movements have secured their position as a magnificent food source for birds, amphibians, and other invertebrates.  Like other branchiopods (a term that comes from the Greek words for "lung" and "foot"), they use the gills on their legs to scrape algae from surfaces and filter organic particles from the water to feed upon.  Endemic to San Diego County's vernal pools, the San Diego Fairy shrimp has been federally listed as an endangered species since 1997, making its existence a continuing source of torment for urban developers and supporters of agricultural conversion in the region.
	The vernal pools that are home to B. sandiegonensis are created when precipitation collects in depressions in an impermeable soil layer on the coastal mesas of San Diego County.  Thus bound to the weather, these pools are characterized by their ephemeral and unpredictable nature; they exhibit an aquatic phase during the late winter and early spring when most of the rains fall and spend much of the remaining year dry.  The length of their filling cycle varies with pool morphology, though most pools are relatively shallow at 5-15 cm and may only hold water for a few days before drying if there is no additional precipitation.  Because of the extreme variability of their aquatic home, fairy shrimp have evolved a number of strategies to ensure that they survive: eggs hatch only when conditions are suitable, nauplii mature and reproduce swiftly at 7-20 days, and adults lay hundreds of eggs before the pool dries (Ripley et al. 2004).  These eggs, known as cysts because of their nearly indestructible nature (fairy shrimp cysts have survived at -150°F, 150°F, and in the pure UV radiation-filled vacuum of space), are perhaps the most remarkable feature of the San Diego fairy shrimp: as a coping mechanism for the high probability of reproductive failure due to extremely variable and fast-drying habitats, only a small fraction of viable cysts in each brood hatches out immediately after it is generated.  The immediately-hatching eggs are known as subitaneous cysts and the remaining diapausing cysts then accumulate in a cyst bank, where their collective variability in hatching times functions as a sort of bet-hedging strategy for failed reproduction.  Any projection of population growth or analysis of population viability for B. sandiegonensis thus must take into account this fractional hatching quality of cysts.   
	Using the estimates of San Diego fairy shrimp vital rates given by Ripley et al., I created a "mean matrix" using the mean parameter values for a reproductively successful filling cycle and a "fail matrix" with expected parameter values for an abortive filling cycle.  Using a program that simulates 200 filling cycles by multiplying a starting population vector by one of the two matrices, randomly chosen, I found that environmental stochasticity can combine with the consequences of failed reproductive cycles to produce a high probability of extinction when the probability of reproductive failure exceeds 0.2.  I found by performing a sensitivity analysis that for "mean" filling cycles population growth is almost exclusively linked to the hatching of subitaneous cysts, followed by the survival of nauplii to adult, while for "fail" cycles population growth is only sensitive to the hatching of cysts that are three or more filling cycles old.  

Methods
	I used the following formulas to construct the two life-history matrices previously discussed:

Adult
Cyst 1
Cyst 2
Cyst 3+
Adult
fec*Hc0*Sna
Sc1*Hc1*Sna
Sc3*Hc3*Sna
Sc3*Hc3*Sna
Cyst 1
fec*(1-Hc0)
0
0
0
Cyst 2
0
Sc1*(1-Hc1)
0
0
Cyst 3
0
0
Sc2*(1-Hc2)
Sc3*(1-Hc3)

	where fec = production of female cysts per female adult
	Hc0 = proportion of eggs that hatch immediately
	(1-Hc0) = proportion of eggs that go into diapause 
	Sc1 = survival of cysts that are one filling cycle old
	Sna = survival of nauplii 

Using the parameter values suggested by Ripley et al., the following is then the constructed mean matrix:
 
Adult
Cyst 1
Cyst 2
Cyst 3+
Adult
6.56
0.03
0.01
0.004
Cyst 1
62.4
0
0
0
Cyst 2
0
0.44
0
0
Cyst 3
0
0
0.49
0.49
 



And the constructed fail matrix:
 
Adult
Cyst 1
Cyst 2
Cyst 3+
Adult
0
0
0
0
Cyst 1
0
0
0
0
Cyst 2
0
0.44
0
0
Cyst 3+
0
0
0.49
0.49

Results and Discussion
	Beginning with 10,000 one filling cycle-old cysts and incrementally increasing the probability of failure, defining a population under 400 individuals (a number that includes both adults and cysts) as extinct, and stipulating that the number of adults in a pool can never exceed 100,000, I generated the following graphs that generally represent the change in cumulative extinction probabilities and population dynamics over time:
 







 
	The preceding graphs should not be seen as a deterministic or precise prediction of population sizes, but rather the observed changes as the probability of reproductive failure increases are meant to reveal the recurring trend of a tremendous increase in cumulative extinction probability and decrease in population size as the probability of choosing the fail matrix increases from 0.2 to 0.3.  Each time the simulation was run the results showed that B. sandiegonensis requires a minimum of one successful reproduction out of every five filling cycles to persist.  This can be an important frequency to keep in mind, as projected trends in climate change suggest that the vernal pools will be facing an increase in failed reproduction due to the decrease in precipitation and hydroperiod.
	Additionally, I investigated the vital rates that most influence change in population growth rates, to understand which parameters of B. sandiegonensis hatching, reproduction, and survival might be most targeted by selective pressures for promoting population growth.  The following is a plot of sensitivities of lambda to hatching of subitaneous cysts, survival of nauplii, survival of cysts of all ages, and the hatching of cysts of all ages during the reproductively successful filling cycles (using the values for the mean matrix):

In contrast, the following is a plot of population growth sensitivities to values for the hatching of cysts at different ages (i.e. "hatch c1" is the hatching of cysts that are one filling cycle old):

	In both graphs, the linear relationships between population growth and the various vital rates imply that there is not an obvious optimal value for any of the vital rates, where the change in lambda is greater at any one vital rate value; instead, the slope of the graph appears to remain the same for all values.  As might be expected, the only vital rates that seem to matter during the mean filling events are the immediate hatching of subitaneous cysts and the survival of hatchlings to adults, whereas during the failed filling events the only vital rate that causes a response in lambda is the hatching of cysts that are three or more filling cycles old.  Specifically, when all filling cycles result in failed reproduction, there is an explicit decrease in population growth as the proportion of cysts that are set aside for storage that hatch increases.  It is perhaps slightly more interesting to note that the results of the sensitivity analysis for mean filling events show that population growth is not affected by any change in survival or hatching of dormant cysts of any age.  Hence, if all filling cycles are mean filling cycles, then population growth is greatest if there is no dormancy at all and all cysts hatch immediately.  Because of the effectively dual nature of population growth sensitivities depending on the type of filling event, it would not be surprising to find that the proportion of cysts that are subitaneous in a vernal pool is the same as the proportion of filling cycles that provide enough water for successful reproduction.  This concept, that a successful B. sandiegonensis population must maintain variation in hatching patterns for long-term survival through environmental stochasticity and failed reproduction, should be taken into account in the event that someone suggests creating a new vernal pool San Diego fairy shrimp population by merely filling a ditch with water and then sprinkling into it a packet of cysts that all came from the same generation of adults.







References

Fugate M. (1993) Branchinecta sandiegonensis, a new species of fairy shrimp (Crustacea: Anostraca) from western North America.  Proceedings of the Biological Society of Washington, 106, 296-304.
Ripley, B. J., J. Holtz, and M. A. Simovich. 2004. Cyst bank life-history model for a fairy shrimp from ephemeral ponds. Freshwater Biology 49: 221-231. 
