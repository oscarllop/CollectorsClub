
using System.ComponentModel.DataAnnotations.Schema;
using CollectorsClub.Model.Entities;

using System.Data.Entity.ModelConfiguration;
using System.Linq;
using System.Text;
namespace CollectorsClub.Model.Configurations {
	public partial class Calendario_IdiomaConfiguration : EntityTypeConfiguration<Calendario_Idioma> {
		public Calendario_IdiomaConfiguration() {
			ToTable("Calendarios_Idiomas");
			HasKey(p => new { p.Id });
			HasRequired(p => p.Registro).WithMany(p => p.RegistrosIdiomas).HasForeignKey(p => new { p.IdRegistro });
			Property(p => p.Id).IsRequired();
			Property(p => p.IdRegistro).IsRequired();
			Property(p => p.Cultura).IsRequired().HasMaxLength(5);
			Property(p => p.Nombre).IsRequired().HasMaxLength(50);
			Property(p => p.Variante).HasMaxLength(50);
		}
	}
}