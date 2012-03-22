Time::DATE_FORMATS[:simple_short] = lambda { |time| time.strftime("%B #{time.day.ordinalize}, %Y") }
Time::DATE_FORMATS[:table] = "%b %e, %Y %m:%M%p"
