incbin "dkong16k.col"

FREE_ROM: equ $b800
CUR_LEVEL: equ $70a6
CUTOFF_LEVEL: equ 96

myorg: macro addr
        seek    addr-$8000
        org     addr
endm

myorg $81ce
        call    fix_bonus

myorg FREE_ROM
fix_bonus:
        push    af
        ; replace original instruction
        ; add 1,000 points to bonus
        ld      de, 100
        ; the bonus gets increased before the level gets incremented,
        ; so if we are in level 96 or above at this point,
        ; don't increase the bonus by 1,000 points.
        ld      a, (CUR_LEVEL)
        cp      CUTOFF_LEVEL
        jr      c, .end
        ld      de, 0
.end:
        pop     af
        ret
