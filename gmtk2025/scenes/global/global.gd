extends Node2D

func cow_type_to_color(cow_type: Cow.CowType) -> Color:
	match cow_type:
		Cow.CowType.PINK:
			return Color(1, 0, 0)
		Cow.CowType.ORANGE:
			return Color(1, 1, 0)
		Cow.CowType.BLACK:
			return Color(0, 1, 1)
	return Color(1, 1, 1)
