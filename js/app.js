const tipo = document.getElementById("tipoRecuperacion");
const label = document.getElementById("labelIdentificador");
const input = document.getElementById("inputIdentificador");

if (tipo && label && input) {
  tipo.addEventListener("change", () => {
    if (tipo.value === "user") {
      label.textContent = "Correo electrónico";
      input.placeholder = "Ingresa tu correo";
    } else if (tipo.value === "password") {
      label.textContent = "Usuario o correo";
      input.placeholder = "Ingresa tu usuario o correo";
    }
  });
}

document.querySelectorAll("[data-toggle]").forEach(btn => {
  btn.addEventListener("click", () => {
    const id = btn.getAttribute("data-toggle");
    const input = document.getElementById(id);
    if (!input) return;

    const icon = btn.querySelector("i");
    const isPass = input.type === "password";
    input.type = isPass ? "text" : "password";

    if (icon) {
      icon.className = isPass ? "bi bi-eye" : "bi bi-eye-slash";
    }
  });
});

const pass1 = document.getElementById("pass1");
const pass2 = document.getElementById("pass2");
const err = document.getElementById("errorPass");

const cumpleRegla = (txt) => /^(?=.*[A-Za-z])(?=.*\d).{8,}$/.test(txt);

if (pass1 && pass2 && err) {
  const mostrarError = (msg) => {
    err.textContent = msg;
    err.style.display = "block";
  };

  const limpiarError = () => {
    err.textContent = "";
    err.style.display = "none";
  };

  const validar = () => {
    const a = pass1.value;
    const b = pass2.value;

    if (a && !cumpleRegla(a)) {
      mostrarError("Debe tener mínimo 8 caracteres e incluir letras y números.");
      return false;
    }
    if (b && !cumpleRegla(b)) {
      mostrarError("La confirmación debe tener mínimo 8 caracteres e incluir letras y números.");
      return false;
    }
    if (a && b && a !== b) {
      mostrarError("Las contraseñas no coinciden. Verifica e intenta de nuevo.");
      return false;
    }

    limpiarError();
    return true;
  };

  pass1.addEventListener("input", validar);
  pass2.addEventListener("input", validar);

  const form = pass1.closest("form");
  if (form) {
    form.addEventListener("submit", (e) => {
      if (!validar()) e.preventDefault();
    });
  }
}


document.querySelectorAll("[data-open]").forEach((btn) => {
  btn.addEventListener("click", () => {
    const id = btn.getAttribute("data-open");
    const modal = document.getElementById(id);
    if (!modal) return;

    const title = btn.getAttribute("data-title");
    const h = modal.querySelector("#modalMesaTitle");
    if (h) h.textContent = title ? title : "Agregar mesa";

    modal.classList.add("show");
  });
});

document.querySelectorAll("[data-close]").forEach((btn) => {
  btn.addEventListener("click", () => {
    const id = btn.getAttribute("data-close");
    const modal = document.getElementById(id);
    if (modal) modal.classList.remove("show");
  });
});

document.addEventListener("keydown", (e) => {
  if (e.key === "Escape") {
    document.querySelectorAll(".modal.show").forEach((m) => m.classList.remove("show"));
  }
});

document.querySelectorAll('[data-delete="true"]').forEach((btn) => {
  btn.addEventListener("click", () => {
    const ok = confirm("¿Seguro que quieres eliminar esta mesa?");
    if (!ok) return;
    alert("Mesa eliminada (solo visual).");
  });
});