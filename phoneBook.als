abstract sig data {}
abstract sig Addr extends data {}
sig email extends Addr {}

abstract sig Name extends data {}

sig Group extends Name {
	member: set data
}

sig Alias extends Name {
	member2: one data
}


fact nonEmptyGroup{
	some x: Group | some x.member
}

fact noCycle{
	no x: Name | x in x.^(member + member2)
}

fact aliasEmail{
	all x: Alias | some e: Addr | e in x.*(member + member2)
}

fact twoLevel{
	some x: data | some y: data | y in x.(member + member2).(member + member2)
}


fun nameOneGroupAtLeast[] : set Name {
	{x: Name | some e: Group | x in e.member}
}

fun emptyGroup[] : set Group {
	{x: Group | no x.member}
}

fun aliasToAddress[] : set Alias -> Addr {
	{x: Alias, y: Addr | y in (x).*(member + member2)}
}
