def clean_it [
  it: record,
  --depth: int,
  --verbose (-v): bool,
] {
  if $depth == 0 {
    return;
  }
  if ($"($it.name)/Cargo.toml" | path exists) and ($"($it.name)/target/" | path exists) {
    cd $it.name;
    echo $"(ansi red_bold)Cleaning: (ansi default)($it.name)";
    rm -r ./target/;
  } else {
    if $it.type == "dir" {
      if $verbose { echo $"(ansi green_bold)Entering: (ansi default)($it.name)"; }
      ls $it.name | each { |it| clean_it $it --depth ($depth - 1) };
    }
  }
}

def clean [
  path: path,
  --depth: int,
  --verbose (-v): bool,
] {
  ls $path | each { |it|
    if $verbose {
      clean_it $it --depth ($depth) --verbose
    } else {
      clean_it $it --depth ($depth)
    }
  };
  echo $"(ansi green_bold)Done.";
}