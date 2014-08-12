function perl_tidy() {
  for x in $(find lib -name '*.pm' ); do perltidy $x; mv $x.tdy $x; echo $x; done
}

function git_status() {
  git status ; read N
}

function git_diff() {
  git diff
}

function git_commit_all() {
  git commit -a
}

function git_fetch_pull_request() {
  dialog --inputbox 'Which pull request?' 10 40 2>$_temp

  if [ $? -eq 0 ]; then
    pr=$(cat $_temp)
    git fetch origin pull/$pr/head:pr/$pr
    git checkout pr/$pr
    if [ $? -ne 0 ]; then
      dialog --msgbox "Error getting pull request"
    fi

  fi
}

function git_push_upstream() {
  current_branch=$(git branch | grep '^*'  | awk ' { print  $2 } ')
  menu_line=""
  iter=0
  remotes=()
  for remote in $(git remote); do
    iter=$[$iter + 1]
    menu_line="$menu_line $iter $remote"
    remotes[$iter]=$remote
  done

  dialog --menu 'Which remote?' 20 40 10 $menu_line 2>$_temp

  if [ $? -eq 0 ]; then
    remote_id=$(cat $_temp)
    echo pushing to ${remotes[$remote_id]}/$current_branch
    sleep 2
    git push ${remotes[$remote_id]} $current_branch
    if [ $? -ne 0 ]; then
      dialog --msgbox "Error pushing to ${remotes[$remote_id]} $current_branch"
    fi
  fi
}
