#!/usr/bin/env bash
worktree_window() {
  # ブランチ名を引数から受け取り
  local branch="$1"
  if [ -z "$branch" ]; then
    echo "usage: worktree_window <branch-name> [base-branch]"
    return 1
  fi
  # どこからブランチを切るか（デフォルト：HEAD）
  local base="${2:-HEAD}"

  # リポジトリルートを取得（フォルダ作成に使用）
  local repo_root
  repo_root=$(git rev-parse --show-toplevel) || return 1
  # リポジトリ名を取得（フォルダ作成に使用）
  local repo_name
  repo_name=$(basename "$repo_root")

  # フォルダ名の設定（ブランチ名の`/`を`-`に置換）
  local dir_name="${branch//\//-}"
  local worktree_dir="${repo_root}/../${repo_name}-worktrees/${dir_name}"

  # worktree作成(既存ブランチなら追跡、新規ならbaseから分岐)
  if git show-ref --verify --quiet "refs/heads/${branch}"; then
    git worktree add "$worktree_dir" "$branch"
  else
    git worktree add -b "$branch" "$worktree_dir" "$base"
  fi

  # tmux内であれば名前つきウィンドウを作成してそのディレクトリを開く
  if [ -n "$TMUX" ]; then
    tmux new-window -n "$branch" -c "$worktree_dir"
  else
    cd "$worktree_dir" || return 1
  fi
}

worktree_window "$@"
