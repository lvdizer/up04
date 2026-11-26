using HelpDeskLesnov.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace HelpDeskLesnov.Views
{
    public partial class TicketEditWindow : Window
    {
        private Ticket ticket;

        public TicketEditWindow(Ticket ticket)
        {
            InitializeComponent();

            this.ticket = ticket;
            FillFields();
        }

        private void FillFields()
        {
            TicketNumberTextBlock.Text = "Заявка №: " + ticket.Id;
            DescriptionTextBox.Text = ticket.Description;

            SelectComboBoxItem(CategoryComboBox, ticket.Category);
            SelectComboBoxItem(PriorityComboBox, ticket.Priority);
            SelectComboBoxItem(StatusComboBox, ticket.Status);
        }

        private static void SelectComboBoxItem(ComboBox comboBox, string value)
        {
            for (int i = 0; i < comboBox.Items.Count; i++)
            {
                ComboBoxItem item = comboBox.Items[i] as ComboBoxItem;

                if (item != null && item.Content.ToString() == value)
                {
                    comboBox.SelectedIndex = i;
                    return;
                }
            }

            if (comboBox.Items.Count > 0)
            {
                comboBox.SelectedIndex = 0;
            }
        }

        private void SaveButton_Click(object sender, RoutedEventArgs e)
        {
            if (CategoryComboBox.SelectedItem == null)
            {
                MessageBox.Show(
                    "Выберите категорию заявки.",
                    "Проверка данных",
                    MessageBoxButton.OK,
                    MessageBoxImage.Warning);

                return;
            }

            if (string.IsNullOrWhiteSpace(DescriptionTextBox.Text))
            {
                MessageBox.Show(
                    "Введите описание проблемы.",
                    "Проверка данных",
                    MessageBoxButton.OK,
                    MessageBoxImage.Warning);

                return;
            }

            if (PriorityComboBox.SelectedItem == null)
            {
                MessageBox.Show(
                    "Выберите приоритет заявки.",
                    "Проверка данных",
                    MessageBoxButton.OK,
                    MessageBoxImage.Warning);

                return;
            }

            if (StatusComboBox.SelectedItem == null)
            {
                MessageBox.Show(
                    "Выберите статус заявки.",
                    "Проверка данных",
                    MessageBoxButton.OK,
                    MessageBoxImage.Warning);

                return;
            }

            ticket.Category = GetComboBoxText(CategoryComboBox);
            ticket.Description = DescriptionTextBox.Text.Trim();
            ticket.Priority = GetComboBoxText(PriorityComboBox);
            ticket.Status = GetComboBoxText(StatusComboBox);

            MessageBox.Show(
                "Изменения заявки сохранены.\n\n" +
                "На следующих занятиях изменения будут сохраняться в MS SQL Server.",
                "HelpDesk",
                MessageBoxButton.OK,
                MessageBoxImage.Information);

            DialogResult = true;
        }

        private void CancelButton_Click(object sender, RoutedEventArgs e)
        {
            Close();
        }

        private static string GetComboBoxText(ComboBox comboBox)
        {
            ComboBoxItem item = comboBox.SelectedItem as ComboBoxItem;
            return item == null ? string.Empty : item.Content.ToString();
        }
    }
}
