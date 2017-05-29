
using System.ComponentModel.DataAnnotations.Schema;
using CollectorsClub.Model.Entities;

using System.Data.Entity.ModelConfiguration;
using System.Linq;
using System.Text;
namespace CollectorsClub.Model.Configurations {
	public partial class UsuarioConfiguration : EntityTypeConfiguration<Usuario> {
		public UsuarioConfiguration() {
			ToTable("Usuarios");
			HasKey(p => new { p.Id });
			HasRequired(p => p.Marca).WithMany(p => p.Usuarios).HasForeignKey(p => new { p.IdMarca });
			Property(p => p.Id).IsRequired();
			Property(p => p.Nombre).IsRequired().HasMaxLength(50);
			Property(p => p.PrimerApellido).IsRequired().HasMaxLength(50);
			Property(p => p.SegundoApellido).IsRequired().HasMaxLength(50);
			Property(p => p.NombreDeUsuario).IsRequired().HasMaxLength(150);
			Property(p => p.CorreoElectronico).IsRequired().HasMaxLength(150);
			Property(p => p.IdMarca).IsRequired().HasMaxLength(3);
		}
	}
}