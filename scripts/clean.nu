def clean [
  it: record,
  --depth: int,
  --quiet (-q): bool,
] {
  if $depth == 0 {
    return;
  }
  if ($"($it.name)/Cargo.toml" | path exists) {
    cd $it.name;
    echo $"(ansi red_bold)Cleaning: (ansi default)($it.name)";
    cargo clean;
  } else {
    if $it.type == "dir" {
      if $quiet { echo $"(ansi green_bold)Entering: (ansi default)($it.name)"; }
      ls $it.name | each { |it| clean $it --depth ($depth - 1) };
    }
  }
}