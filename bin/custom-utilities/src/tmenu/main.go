package main

import (
	"fmt"
	"os"

	tea "github.com/charmbracelet/bubbletea"
)

// Model
type model struct {
  items []string
  selected int
}

func initialModel() model {
  return model{
    items: os.Args[1:],
    selected: 0,
  }
}


func (m model) Init() tea.Cmd {
  return nil
}

func (m model) Update(msg tea.Msg) (tea.Model, tea.Cmd) {
  switch msg := msg.(type) {
  case tea.KeyMsg:
    switch msg.String() {
    case "k":
      if m.selected > 0 {
        m.selected--
      }
    case "j":
      if m.selected < len(m.items) - 1 {
        m.selected++
      }
    case "q":
      return m, tea.Quit
    case "enter", " ":
      item := m.items[m.selected]
      fmt.Printf("%s", item)
      return m, tea.Quit
    }
  }
  return m, nil
}

func (m model) View() string {
  s := "\n"
  for i, item := range m.items {
    cursor := " "
    if m.selected == i {
      cursor = ">"
    }
    s+= fmt.Sprintf("%s %s\n", cursor, item)
  }
  s+="\n"
  return s
}

func main() {
  p := tea.NewProgram(initialModel(), tea.WithOutput(os.Stderr))
  if err := p.Start(); err != nil {
    fmt.Printf("Error: %v", err)
    os.Exit(1)
  }
}
