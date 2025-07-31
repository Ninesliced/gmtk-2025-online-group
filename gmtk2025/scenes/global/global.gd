extends Node2D

func cow_type_to_color(cow_type: Cow.CowType) -> Color:
	match cow_type:
		Cow.CowType.RED:
			return Color(1, 0, 0)
		Cow.CowType.YELLOW:
			return Color(1, 1, 0)
		Cow.CowType.BLUE:
			return Color(0, 1, 1)
	return Color(1, 1, 1)
