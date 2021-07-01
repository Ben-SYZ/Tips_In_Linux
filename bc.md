https://unix.stackexchange.com/questions/49850/does-bc-support-hex-calculations
```sh
    variance=$(bc <<<$(echo -e "
	ibase=16;obase=10
	scale=0
	( ($ref_r_comp-$pixel_r_comp)^2 + \
	($ref_g_comp-$pixel_g_comp)^2 + \
	($ref_b_comp-$pixel_b_comp)^2 )/2
    "
    ))
    echo $variance
```
