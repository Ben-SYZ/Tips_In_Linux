
syn match texMathSymbol '\\alpha\>' contained conceal cchar=α
syn match texMathSymbol '\\beta\>' contained conceal cchar=β
syn match texMathSymbol '\\gamma\>' contained conceal cchar=γ
syn match texMathSymbol '\\delta\>' contained conceal cchar=δ
syn match texMathSymbol '\\epsilon\>' contained conceal cchar=ϵ
syn match texMathSymbol '\\zeta\>' contained conceal cchar=ζ
syn match texMathSymbol '\\eta\>' contained conceal cchar=η
syn match texMathSymbol '\\theta\>' contained conceal cchar=θ
syn match texMathSymbol '\\iota\>' contained conceal cchar=ι
syn match texMathSymbol '\\kappa\>' contained conceal cchar=κ
syn match texMathSymbol '\\lambda\>' contained conceal cchar=λ
syn match texMathSymbol '\\mu\>' contained conceal cchar=μ
syn match texMathSymbol '\\nu\>' contained conceal cchar=ν
syn match texMathSymbol '\\xi\>' contained conceal cchar=ξ
syn match texMathSymbol '\\omicron\>' contained conceal cchar=ο
syn match texMathSymbol '\\pi\>' contained conceal cchar=π
syn match texMathSymbol '\\rho\>' contained conceal cchar=ρ
syn match texMathSymbol '\\sigma\>' contained conceal cchar=σ
syn match texMathSymbol '\\tau\>' contained conceal cchar=τ
syn match texMathSymbol '\\upsilon\>' contained conceal cchar=υ
syn match texMathSymbol '\\phi\>' contained conceal cchar=ϕ
syn match texMathSymbol '\\chi\>' contained conceal cchar=χ
syn match texMathSymbol '\\psi\>' contained conceal cchar=ψ
syn match texMathSymbol '\\omega\>' contained conceal cchar=ω


syn match texMathSymbol '\\Alpha\>' contained conceal cchar=A
syn match texMathSymbol '\\Beta\>' contained conceal cchar=B
syn match texMathSymbol '\\Gamma\>' contained conceal cchar=Γ
syn match texMathSymbol '\\Delta\>' contained conceal cchar=Δ
syn match texMathSymbol '\\Epsilon\>' contained conceal cchar=E
syn match texMathSymbol '\\Zeta\>' contained conceal cchar=Z
syn match texMathSymbol '\\Eta\>' contained conceal cchar=H
syn match texMathSymbol '\\Theta\>' contained conceal cchar=Θ
syn match texMathSymbol '\\Iota\>' contained conceal cchar=I
syn match texMathSymbol '\\Kappa\>' contained conceal cchar=K
syn match texMathSymbol '\\Lambda\>' contained conceal cchar=Λ
syn match texMathSymbol '\\Mu\>' contained conceal cchar=M
syn match texMathSymbol '\\Nu\>' contained conceal cchar=N
syn match texMathSymbol '\\Xi\>' contained conceal cchar=Ξ
syn match texMathSymbol '\\Omicron\>' contained conceal cchar=O
syn match texMathSymbol '\\Pi\>' contained conceal cchar=Π
syn match texMathSymbol '\\Rho\>' contained conceal cchar=P
syn match texMathSymbol '\\Sigma\>' contained conceal cchar=Σ
syn match texMathSymbol '\\Tau\>' contained conceal cchar=T
syn match texMathSymbol '\\Upsilon\>' contained conceal cchar=Υ
syn match texMathSymbol '\\Phi\>' contained conceal cchar=Φ
syn match texMathSymbol '\\Chi\>' contained conceal cchar=X
syn match texMathSymbol '\\Psi\>' contained conceal cchar=Ψ
syn match texMathSymbol '\\Omega\>' contained conceal cchar=Ω
syn match texMathSymbol '\\varepsilon\>' contained conceal cchar=ε
syn match texMathSymbol '\\vartheta\>' contained conceal cchar=ϑ
syn match texMathSymbol '\\varkappa\>' contained conceal cchar=ϰ
syn match texMathSymbol '\\varpi\>' contained conceal cchar=ϖ
syn match texMathSymbol '\\varrho\>' contained conceal cchar=ϱ
syn match texMathSymbol '\\varsigma\>' contained conceal cchar=ς
syn match texMathSymbol '\\varphi\>' contained conceal cchar=φ
syn match texMathSymbol '\<++>\>' contained conceal cchar=<++>
syn match texMathSymbol '\<++>\>' contained conceal cchar=<++>
syn match texMathSymbol '\<++>\>' contained conceal cchar=<++>
syn match texMathSymbol '\<++>\>' contained conceal cchar=<++>

# following is the macro to make the conceal
  Gd2wpx  ggxpn0

(2) 使用命令 "ap 将寄存器a中的命令宏粘贴到当前位置，然后编辑这一行的宏内容，编辑结束后用 0 回到行首

(3) 使用命令 "ayy 将当前行的内容复制到寄存器a中，达到修改寄存器a宏内容的目的



