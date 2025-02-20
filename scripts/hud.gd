extends Control


func set_time_label(value):
	$TimeLabel.text = "TIME: " + str(value)
	
func set_burger_label(collected_burgers, total_burgers):
	$BurgerLabel.text = "BURGERS: " + str(collected_burgers) + "/" + str(total_burgers)

func set_boost_amount(value):
	$BoostLabel.text = "BOOST:" + str(value)
