#!/bin/bash

# Check if two arguments are provided
if [ $# -ne 2 ]; then
  echo "Usage: $0 <size> <type>"
  exit 1
fi

size=$1
type=$2

draw_type1() {
  for (( i=1; i<=size; i++ )); do
    printf "%*s" $((size-i)) ""
    for (( j=1; j<=i; j++ )); do
      printf "*"
    done
    echo ""
  done
}

draw_type2() {
  for (( i=1; i<=size; i++ )); do
    for (( j=1; j<=i; j++ )); do
      printf "*"
    done
    echo ""
  done
}

draw_type3() {
  for (( i=1; i<=size; i++ )); do
    printf "%*s" $((size-i)) ""
    for (( j=1; j<=(2*i-1); j++ )); do
      printf "*"
    done
    echo ""
  done
}

draw_type4() {
  for (( i=size; i>=1; i-- )); do
    for (( j=1; j<=i; j++ )); do
      printf "*"
    done
    echo ""
  done
}

draw_type5() {
  for (( i=size; i>=1; i-- )); do
    printf "%*s" $((size-i)) ""
    for (( j=1; j<=i; j++ )); do
      printf "*"
    done
    echo ""
  done
}

draw_type6() {
  for (( i=size; i>=1; i-- )); do
    printf "%*s" $((size-i)) ""
    for (( j=1; j<=(2*i-1); j++ )); do
      printf "*"
    done
    echo ""
  done
}

draw_type7() {
  # Top triangle
  for (( i=1; i<=size; i++ )); do
    printf "%*s" $((size-i)) ""
    for (( j=1; j<=(2*i-1); j++ )); do
      printf "*"
    done
    echo ""
  done

  for (( i=size-1; i>=1; i-- )); do
    printf "%*s" $((size-i)) ""
    for (( j=1; j<=(2*i-1); j++ )); do
      printf "*"
    done
    echo ""
  done
}

case $type in
  t1) draw_type1 ;;
  t2) draw_type2 ;;
  t3) draw_type3 ;;
  t4) draw_type4 ;;
  t5) draw_type5 ;;
  t6) draw_type6 ;;
  t7) draw_type7 ;;
  *)
    echo "Invalid type. Please choose from t1, t2, t3, t4, t5, t6, or t7."
    exit 1
    ;;
esac

